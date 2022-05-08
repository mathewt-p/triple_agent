namespace :games do

  desc "Games"

  task round_1: :environment do
    Game.destroy_all
    game = Game.create!(name: "round 1")
    # set virus agents
    game.players.create!((1..4).map{|t| {p_number: t, role: 1}})
    # set fbi agents
    game.players.create!((5..12).map{|t| {p_number: t}})

    game.levels.create!([
      {priority: 1, private_message: "From $$ and $$ atleast one of them is a virus agent", public_message: "is getting a clue", private_player: 2, private_message_variables: [7,3]},
      {priority: 2, private_message: "You and $$ are on the same team", public_message: "is getting a clue", private_player: 8, private_message_variables: [4]},
      {priority: 3, private_message: "You and $$ are on differnet teams", public_message: "is getting an info about one person", private_player: 10, private_message_variables: [2]},
      {priority: 4, private_message: "You have flipped sides to FBI, DO NOT openly reveal this if the other virus agents know about this, they will kill you in your sleep.|(Hint lie about this info and try to give a similar info that was given to others)", public_message: "is getting some random info", private_player: 4, private_message_variables: []},
      {priority: 5, private_message: "$$ and $$ are from the same team", public_message: "is getting an info about two people", private_player: 1, private_message_variables: [10,9]},
      {priority: 6, private_message: "You get info that $$ might try to betray your team and switch sides", public_message: "is getting an info about one person", private_player: 3, private_message_variables: [4]},
      {priority: 7, private_message: "You hate $$ so much you have to send him to jail to win(else you wont win) ", public_message: "is getting an info about one person", private_player: 9, private_message_variables: [4]},
      {priority: 8, private_message: "You and $$ are in love and you have to save them from jail by going to jail yourself to win(else you wont win) ", public_message: "is getting an info about one person", private_player: 6, private_message_variables: [3]},
      {priority: 9, private_message: "You get info that $$ is an FBI agent ", public_message: "is getting an info about one person", private_player: 7, private_message_variables: [10]},
      {priority: 10, private_message: "Do not trust one of $$ or $$ as one of them might have(or get) a secret mission.", public_message: "is getting some info", private_player: 5, private_message_variables: [6, 4]},
    ])
    game.win_conditions.create!([
      {jailed: 0, winners: [1, 2, 3]},
      {jailed: 1, winners: [4, 7, 8, 5, 10]},
      {jailed: 2, winners: [4, 7, 8, 5, 10]},
      {jailed: 3, winners: [4, 7, 8, 5, 10]},
      {jailed: 4, winners: [1, 2, 3, 9]},
      {jailed: 5, winners: [1, 2, 3]},
      {jailed: 6, winners: [6]},
      {jailed: 7, winners: [1, 2, 3]},
      {jailed: 8, winners: [1, 2, 3]},
      {jailed: 9, winners: [1, 2, 3]},
      {jailed: 10, winners: [1, 2, 3]},
    ])
    p "Game set"
  end

  task start: :environment do
    UserPlayer.destroy_all
    game = Game.first
    if !game
      p "Create a Game"
    else
      players = game.players
      players.each do |player|
        user = User.all.select{|t| t.player.nil?}
        # user =  User.all if user.empty?
        break if user.empty?
        player.create_user_player!(user_id: user.sample(1).first.id)
      end
      p "User player set"

      game.messages.create(content: "Everyone has been assigned a role, Good luck")

      players.each do |player|
        room = player.user&.private_room
        if room
          room.messages.create(content: "#{player.message} #{Player::PrivateMessageEnding}")
          PrivateMessageCleanerJob.perform_in(15.seconds, room.id)
        end
      end
      p "User roles send"
    end
  end

  task next_level: :environment do
    game = Game.first
    if !game
      p "Create a Game"
    elsif game.current_level > game.levels.count
      # initiate voting

    else
      level = game.levels.find_by(priority: game.current_level)
      game.increment!(:current_level)
      private_player = Player.find(level.private_player)
      public_message = "#{private_player.name} #{level.public_message}"
      public_room = game.public_room
      public_room.messages.create(content: public_message)
      vars = level.private_message_variables.clone
      private_message = level.private_message.clone
      (1..vars.count).each do |i|
        private_message = private_message.sub('$$', Player.find(vars.shift).username)
      end
      private_player.user.private_room.messages.create(content: private_message)
    end
  end

  task test_public_message: :environment do
    room = Game.first.public_room
    room.messages.create(content: "Test public message")
    Message.destroy_all
  end

  task test_private_message: :environment do
    players = Game.first.players
    players.each do |player|
      room = player.user.private_room
      room.messages.create(content: "Test private message to #{player.name}")
        PrivateMessageCleanerJob.perform_in(5.seconds, room.id)
    end
    Message.destroy_all
  end

  task reset_game: :environment do
    Game.destroy_all
    p "Done."
  end
end

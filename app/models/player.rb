class Player < ApplicationRecord
  belongs_to :game
  has_one :user_player
  has_one :user, through: :user_player
  enum role: [:fbi, :virus]

  PrivateMessageEnding = "Good luck, This message will self destruct in 15 seconds"

  def name
    user.username rescue nil
  end

  def message
    if fbi?
      "You are a FBI agent, you are tasked with finding out and taking down the members of the Virus organisation."
    else
      "You are a member of the Virus organisation, you are tasked with saving your fellow members from jail. You fellow members are [#{list_virus_agents}]."
    end
  end

  def virus_agents
    Player.virus
  end

  def list_virus_agents
    virus_agents.where.not(id: id).map{|tt| "#{tt.user&.username}"}.join(", ")
  end
end

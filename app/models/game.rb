class Game < ApplicationRecord
  has_many :levels, dependent: :destroy
  has_many :players, dependent: :destroy
  has_many :win_conditions, dependent: :destroy
  has_one :public_room, class_name: "Room", dependent: :destroy
  after_create :set_game_room



  def set_game_room
    room_name = "game_#{id}_room"
    create_public_room(name: room_name)
  end

  def messages
    public_room.messages
  end
end

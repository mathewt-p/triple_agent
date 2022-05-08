class User < ApplicationRecord
  validates_uniqueness_of :username
  scope :all_except, ->(user) { where.not(id: user) }
  # after_create_commit { broadcast_append_to "users" }
  after_create :set_room
  # has_many :messages
  has_one :private_room, class_name: "Room", foreign_key: "target_user_id"
  has_one :user_player, dependent: :destroy
  has_one :player, through: :user_player



  def set_room
    room_name = "private_#{id}_room"
    private_room = create_private_room(name: room_name, is_private: true)
  end
end

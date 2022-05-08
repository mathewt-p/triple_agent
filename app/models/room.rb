class Room < ApplicationRecord
  belongs_to :target_user, class_name: "User", required: false
  belongs_to :game, required: false
  # validates_uniqueness_of :name
  # scope :public_rooms, -> { where(is_private: false) }
  # after_create_commit { broadcast_if_public }
  has_many :messages, dependent: :destroy

  # def broadcast_if_public
  #   broadcast_append_to "rooms" unless self.is_private
  # end

  # def self.create_private_room(user, room_name)
  #   Room.create(name: room_name, is_private: true, target_user_id: user.id)
  # end

  # def target_user
  #   @target_user ||= User.find_by(id: target_user_id)
  # end
end

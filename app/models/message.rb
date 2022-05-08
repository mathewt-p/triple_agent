class Message < ApplicationRecord
  # belongs_to :user
  belongs_to :room
  after_create_commit :broadcast_message


  def broadcast_message
    if !room.is_private
      broadcast_append_to room, target: "group_messages"
    else
      broadcast_update_to room, target: "private_messages"
    end
  end
end

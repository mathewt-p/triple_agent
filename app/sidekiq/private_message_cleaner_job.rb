class PrivateMessageCleanerJob
  include Sidekiq::Job

  def perform(room_id)
    room = Room.find(room_id)
    p room_id
    room.messages.create(content: "☣☣☣")
    # room.messages.destroy_all if room.is_private
  end
end

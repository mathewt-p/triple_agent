class AddGameIdToRooms < ActiveRecord::Migration[6.1]
  def change
    add_column :rooms, :game_id, :string, default: ""
  end
end

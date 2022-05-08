class AddTargetUserIdToRooms < ActiveRecord::Migration[6.1]
  def change
    add_column :rooms, :target_user_id, :string, default: ""
  end
end

class CreateUserPlayers < ActiveRecord::Migration[6.1]
  def change
    create_table :user_players do |t|
      t.belongs_to :user
      t.belongs_to :player

      t.timestamps
    end
  end
end

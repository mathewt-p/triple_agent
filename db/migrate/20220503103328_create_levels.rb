class CreateLevels < ActiveRecord::Migration[6.1]
  def change
    create_table :levels do |t|
      t.belongs_to :game
      t.text  :private_message
      t.text  :public_message
      t.jsonb :private_players
      t.timestamps
    end
  end
end

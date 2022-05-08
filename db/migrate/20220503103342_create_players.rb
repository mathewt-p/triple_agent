class CreatePlayers < ActiveRecord::Migration[6.1]
  def change
    create_table :players do |t|
      t.belongs_to :game
      t.string   :p_number

      t.timestamps
    end
  end
end

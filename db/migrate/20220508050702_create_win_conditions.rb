class CreateWinConditions < ActiveRecord::Migration[6.1]
  def change
    create_table :win_conditions do |t|
      t.belongs_to :game
      t.integer :jailed, default: 0
      t.jsonb :winners

      t.timestamps
    end
  end
end

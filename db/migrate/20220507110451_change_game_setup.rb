class ChangeGameSetup < ActiveRecord::Migration[6.1]
  def change
    remove_column :levels, :private_players
    add_column :levels, :private_player, :integer
    add_column :levels, :private_message_variables, :jsonb, default: []
    add_column :games, :current_level, :integer, default: 1
  end
end

class AddActiveToGames < ActiveRecord::Migration[6.1]
  def change
    add_column :games, :active, :boolean, default: false
  end
end

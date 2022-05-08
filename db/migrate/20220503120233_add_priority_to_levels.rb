class AddPriorityToLevels < ActiveRecord::Migration[6.1]
  def change
    add_column :levels, :priority, :integer, default: 9999
  end
end

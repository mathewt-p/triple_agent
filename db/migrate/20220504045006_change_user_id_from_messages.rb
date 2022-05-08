class ChangeUserIdFromMessages < ActiveRecord::Migration[6.1]
  def change
    remove_foreign_key :messages, :users
  end
end

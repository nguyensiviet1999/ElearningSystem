class AddGoldToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :gold, :integer
  end
end

class AddReadyToJoinRoom < ActiveRecord::Migration[6.0]
  def change
    add_column :join_rooms, :ready, :boolean, default: false
  end
end

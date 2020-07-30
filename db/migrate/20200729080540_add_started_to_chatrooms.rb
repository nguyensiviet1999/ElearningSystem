class AddStartedToChatrooms < ActiveRecord::Migration[6.0]
  def change
    add_column :chatrooms, :started, :boolean, default: false
    #Ex:- :default =>''
  end
end

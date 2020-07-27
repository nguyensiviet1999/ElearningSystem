class AddSlugToChatroom < ActiveRecord::Migration[6.0]
  def change
    add_column :chatrooms, :slug, :text
  end
end

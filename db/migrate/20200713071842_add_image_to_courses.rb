class AddImageToCourses < ActiveRecord::Migration[6.0]
  def change
    add_column :Courses, :image, :string
    add_column :Words, :image, :string
  end
end

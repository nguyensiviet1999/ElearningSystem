class AddImageToCourses < ActiveRecord::Migration[6.0]
  def change
    add_column :courses, :image, :string
    add_column :words, :image, :string
  end
end

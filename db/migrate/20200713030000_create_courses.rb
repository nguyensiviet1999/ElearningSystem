class CreateCourses < ActiveRecord::Migration[6.0]
  def change
    create_table :courses do |t|
      t.string :course_name
      t.references :category, null: false, foreign_key: true
      t.text :content
      t.timestamps
    end
  end
end

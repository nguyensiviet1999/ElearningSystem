class CreateCourseWords < ActiveRecord::Migration[6.0]
  def change
    create_table :course_words do |t|
      t.references :course
      t.references :word

      t.timestamps
    end
  end
end

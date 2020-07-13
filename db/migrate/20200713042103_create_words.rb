class CreateWords < ActiveRecord::Migration[6.0]
  def change
    create_table :words do |t|
      t.references :course, null: false, foreign_key: true
      t.string :word
      t.string :meaning

      t.timestamps
    end
  end
end

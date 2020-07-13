class CreateUserLearnedWords < ActiveRecord::Migration[6.0]
  def change
    create_table :user_learned_words do |t|
      t.references :word, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end

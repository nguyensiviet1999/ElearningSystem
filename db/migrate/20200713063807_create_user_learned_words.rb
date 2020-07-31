class CreateUserLearnedWords < ActiveRecord::Migration[6.0]
  def change
    create_table :user_learned_words do |t|
      t.references :word
      t.references :user

      t.timestamps
    end
  end
end

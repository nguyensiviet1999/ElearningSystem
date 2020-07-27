class CreateChatrooms < ActiveRecord::Migration[6.0]
  def change
    create_table :chatrooms do |t|
      t.integer :course_id
      t.integer :number_of_words
      t.integer :gold_bet
      t.integer :number_members
      t.string :topic

      t.timestamps
    end
  end
end

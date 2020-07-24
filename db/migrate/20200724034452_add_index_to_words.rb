class AddIndexToWords < ActiveRecord::Migration[6.0]
  def change
    add_index :words, :word
    add_index :words, :meaning
  end
end

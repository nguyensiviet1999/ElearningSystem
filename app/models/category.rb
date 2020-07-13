class Category < ApplicationRecord
    validates :name_category, presence: true, uniqueness: { case_sensitive: false }, length: {maximum: 50}
    
    
end

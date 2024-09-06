class About < ApplicationRecord
  has_rich_text :content
  
  belongs_to :user
  validates :content, presence: true
end

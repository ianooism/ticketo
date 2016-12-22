class Comment < ApplicationRecord
  belongs_to :ticket
  belongs_to :owner, class_name: 'User'
  
  validates :body, presence: true
end

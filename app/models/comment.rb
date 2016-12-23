class Comment < ApplicationRecord
  belongs_to :ticket
  belongs_to :owner, class_name: 'User'
  belongs_to :state
  
  validates :body, presence: true
end

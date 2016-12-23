class Ticket < ApplicationRecord
  include Ownable
  
  belongs_to :project
  belongs_to :owner, class_name: 'User'
  
  has_many :comments
  
  validates :name, presence: true
end

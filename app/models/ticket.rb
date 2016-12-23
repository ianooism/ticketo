class Ticket < ApplicationRecord
  include Ownable
  
  belongs_to :project
  belongs_to :owner, class_name: 'User'
  belongs_to :state
  
  has_many :comments
  
  validates :name, presence: true
end

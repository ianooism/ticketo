class Ticket < ApplicationRecord
  include Ownable
  
  belongs_to :project
  belongs_to :owner, class_name: 'User'
  
  validates :name, presence: true
end

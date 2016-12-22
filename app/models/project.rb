class Project < ApplicationRecord
  include Ownable
  
  belongs_to :owner, class_name: 'User'
  
  has_many :tickets
  
  validates :name, presence: true
end

class Project < ApplicationRecord
  include Ownable
  
  belongs_to :owner, class_name: 'User'
  
  has_many :tickets, dependent: :destroy
  
  validates :name, presence: true
end

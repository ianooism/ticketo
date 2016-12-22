class Project < ApplicationRecord
  belongs_to :owner, class_name: 'User'
  
  has_many :tickets
  
  validates :name, presence: true
  
  def owner?(user)
    self.owner == user
  end
end

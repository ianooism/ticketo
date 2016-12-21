class Project < ApplicationRecord
  belongs_to :owner, class_name: 'User'
  
  validates :name, presence: true
  
  def owner?(user)
    self.owner == user
  end
end

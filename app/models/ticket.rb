class Ticket < ApplicationRecord
  include Ownable
  
  belongs_to :project
  belongs_to :owner, class_name: 'User'
  belongs_to :state
  
  has_many :comments, dependent: :destroy
  
  validates :name, presence: true
  
  before_validation :set_state, if: :new_record?
  
  private
    def set_state
      self.state = State.default
    end
end

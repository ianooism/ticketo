class Ticket < ApplicationRecord
  include Ownable
  
  belongs_to :project
  belongs_to :owner, class_name: 'User'
  belongs_to :state
  
  has_many :comments
  
  validates :name, presence: true
  
  after_initialize :set_state, if: :new_record?
  
  private
    def set_state
      self.state ||= State.default
    end
end

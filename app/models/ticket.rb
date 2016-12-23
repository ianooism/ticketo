class Ticket < ApplicationRecord
  include Ownable
  
  belongs_to :project
  belongs_to :owner, class_name: 'User'
  belongs_to :state
  
  has_many :comments
  
  after_initialize :set_state, if: :new_record?
  
  validates :name, presence: true
  
  private
    def set_state
      self.state ||= State.default
    end
end

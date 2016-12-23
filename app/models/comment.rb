class Comment < ApplicationRecord
  belongs_to :ticket
  belongs_to :owner, class_name: 'User'
  belongs_to :state
  belongs_to :previous_state, class_name: 'State'
  
  validates :body, presence: true
  
  before_validation :set_previous_state, if: :new_record?
  after_save :set_state_on_ticket
  
  private
    def set_previous_state
      self.previous_state = ticket.state
    end
    
    def set_state_on_ticket
      ticket.state = self.state
      ticket.save!
    end
end

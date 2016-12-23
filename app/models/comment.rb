class Comment < ApplicationRecord
  belongs_to :ticket
  belongs_to :owner, class_name: 'User'
  belongs_to :state
  
  validates :body, presence: true
  
  after_create :set_state_on_ticket
  
  private
    def set_state_on_ticket
      ticket.state = self.state
      ticket.save!
    end
end

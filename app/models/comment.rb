class Comment < ApplicationRecord
  attr_accessor :tag_names
  
  belongs_to :ticket
  belongs_to :owner, class_name: 'User'
  belongs_to :state
  belongs_to :previous_state, class_name: 'State'
  
  validates :body, presence: true
  
  after_initialize :set_states, if: :new_record?
  
  private
    def set_states
      self.state = ticket.state
      self.previous_state = state
    end
end

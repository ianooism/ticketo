class Comment < ApplicationRecord
  belongs_to :ticket
  belongs_to :owner, class_name: 'User'
  belongs_to :state
  belongs_to :previous_state, class_name: 'State'
  
  # state for comment and ticket
  after_initialize :set_state, if: :new_record?
  before_validation :set_previous_state, if: :new_record?
  after_save :set_state_for_ticket
  
  # tags for ticket
  attr_reader :tag_names
  def tag_names=(names)
    @tag_names = names
    names.split.each do |name|
      ticket.tags << Tag.find_or_initialize_by(name: name)
    end
  end
  
  # watchers for ticket
  after_create :set_watchers_for_ticket
  
  validates :body, presence: true
  
  private
    def set_state
      self.state = ticket.state
    end
    
    def set_previous_state
      self.previous_state = ticket.state
    end
    
    def set_state_for_ticket
      ticket.update!(state: state)
    end
    
    def set_watchers_for_ticket
      ticket.watchers << owner unless ticket.watchers.include?(owner)
    end
end

class Comment < ApplicationRecord
  belongs_to :ticket
  belongs_to :owner, class_name: 'User'
  belongs_to :state
  belongs_to :previous_state, class_name: 'State'
  
  validates :body, presence: true
  
  after_initialize :set_state, if: :new_record?
  before_validation :set_previous_state, if: :new_record?
  after_save :set_state_on_ticket
  
  def tag_names
    @tag_names = ticket.tags.map(&:name).join(' ')
  end
  
  def tag_names=(names)
    @tag_names = names
    names.split.each do |name|
      ticket.tags << Tag.find_or_initialize_by(name: name)
    end
  end
  
  private
    def set_state
      self.state = ticket.state
    end
    
    def set_previous_state
      self.previous_state = ticket.state
    end
    
    def set_state_on_ticket
      ticket.state = self.state
      ticket.save!
    end
end

class Ticket < ApplicationRecord
  include Ownable
  
  belongs_to :project
  belongs_to :owner, class_name: 'User'
  belongs_to :state
  has_many :comments, dependent: :destroy
  has_and_belongs_to_many :tags, -> { distinct }
  has_and_belongs_to_many :watchers,
                          { class_name: 'User', join_table: :tickets_watchers },
                          -> { distinct }
  
  # state for ticket
  before_validation :set_state, if: :new_record?
  
  # tags for ticket
  def tag_names
    @tag_names = tags.map(&:name).join(' ') unless new_record?
    @tag_names
  end
  def tag_names=(names)
    @tag_names = names
    names.split.each do |name|
      self.tags << Tag.find_or_initialize_by(name: name)
    end
  end
  
  # watchers for ticket
  after_create :set_watchers
  
  validates :name, presence: true
  
  private
    def set_state
      self.state = State.default
    end
    
    def set_watchers
      self.watchers << owner unless watchers.include?(owner)
    end
end

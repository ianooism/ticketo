class Ticket < ApplicationRecord
  include Ownable
  
  belongs_to :project
  belongs_to :owner, class_name: 'User'
  belongs_to :state
  has_many :comments, dependent: :destroy
  has_and_belongs_to_many :tags, -> { distinct }
  
  def tag_names
    @tag_names = self.tags.map(&:name).join(' ') unless self.new_record?
    @tag_names
  end
  def tag_names=(names)
    @tag_names = names
    names.split.each do |name|
      self.tags << Tag.find_or_initialize_by(name: name)
    end
  end
  
  validates :name, presence: true
  
  before_validation :set_state, if: :new_record?
  
  private
    def set_state
      self.state = State.default
    end
end

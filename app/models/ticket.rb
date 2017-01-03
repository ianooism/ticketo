class Ticket < ApplicationRecord
  include Ownable
  
  attr_accessor :tag_names
  
  belongs_to :project
  belongs_to :owner, class_name: :User
  belongs_to :state
  
  has_many :comments, dependent: :destroy
  has_and_belongs_to_many :tags, -> { distinct }
  has_and_belongs_to_many :watchers, -> { distinct },
                          { class_name: :User, join_table: :tickets_watchers }
  
  validates :name, presence: true
  
  after_initialize :format_tags, unless: :new_record?
  after_initialize :set_state, if: :new_record?
  after_create :add_tags
  after_create :add_watcher
  
  def watch(watcher)
    add_watcher(watcher)
  end
  
  def unwatch(watcher)
    watchers.destroy(watcher)
  end
  
  def update_association(args)
    state = args.fetch(:state, nil)
    tags = args.fetch(:tags, nil)
    watcher = args.fetch(:watcher, nil)
    
    set_state(state) if state
    add_tags(tags) if tags
    add_watcher(watcher) if watcher
  end
  
  private
    def format_tags
      self.tag_names = tags.map(&:name).join(' ')
    end
    
    def set_state(new_state = State.default)
      self.state = new_state
      save! unless new_record?
    end
    
    def add_tags(names = tag_names)
      names.split.each do |name|
        self.tags << Tag.find_or_initialize_by(name: name)
      end
    end
    
    def add_watcher(watcher = owner)
      unless watchers.include?(watcher)
        self.watchers << watcher
      end
    end
end

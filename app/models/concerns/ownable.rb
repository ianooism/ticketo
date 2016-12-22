module Ownable
  extend ActiveSupport::Concern
  
  def owner?(user)
    self.owner == user
  end
end

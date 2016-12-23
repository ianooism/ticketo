class State < ApplicationRecord
  def self.default
    find_by(default: true)
  end
end

class User < ApplicationRecord
  validates_uniqueness_of :name, nil: false
end

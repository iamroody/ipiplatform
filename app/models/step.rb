class Step < ActiveRecord::Base
  has_many :resources
  validates :name, presence: true
end

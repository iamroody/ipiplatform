class Phase < ActiveRecord::Base
  has_many :phase_associations
  has_many :resources, through: :phase_associations
end
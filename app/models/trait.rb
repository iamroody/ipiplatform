class Trait < ActiveRecord::Base
  has_many :trait_associations
  has_many :resources, through: :trait_associations
end

class Step < ActiveRecord::Base
  has_and_belongs_to_many :resources
  acts_as_list :scope => :journey
  belongs_to :journey
  validates :name, presence: true

  def add_resource(resource)
    self.resources.push(resource)
  end
end

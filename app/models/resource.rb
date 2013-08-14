class Resource < ActiveRecord::Base
  has_many :trait_associations
  has_many :traits, through: :trait_associations
  has_many :resource_industries
  has_many :industries, through: :resource_industries
  has_many :upvotes, :dependent => :destroy
  has_many :bookmarks, :dependent => :destroy
  has_many :users, through: :bookmarks

  belongs_to :user
  
  attr_writer :current_step
  
  def current_step
    @current_step ||  steps.first
  end
  
  def steps
    ["basicresourceinfo", "resourcetags"]
  end
  
  def first_step?
    current_step == steps.first
  end
  
  def last_step?
    current_step == steps.last
  end
  
  def next_step
    self.current_step = steps[steps.index(current_step)+1]
  end
  
  def previous_step
    self.current_step = steps[steps.index(current_step)-1]
  end
  
  def all_valid?
    steps.all? do |step|
      self.current_step = step
      valid?
    end
  end

  def author
    if self.user_id
      author = User.find(self.user_id)
    else
      author = User.new(name: 'IPI Team', email: 'ipi@sidekick.com')
    end
  end

  def user_upvote(current_user)
    Upvote.where("user_id=? and resource_id=?", current_user.id, self.id)
  end
end

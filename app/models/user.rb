class User < ActiveRecord::Base
  has_secure_password

  #attr_accessible :email, :name, :password, :password_confirmation
  has_many :resources

  has_many :upvotes

  validates_uniqueness_of :email
end

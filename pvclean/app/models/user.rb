class User < ActiveRecord::Base
  validates_presence_of :name
  after_create :assign_default_role
  rolify
  resourcify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Adds role to a new created user
  def assign_default_role
    self.add_role(:newuser) if self.roles.blank?
  end
end

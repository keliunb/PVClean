class User < ActiveRecord::Base
  validates_presence_of :name
  before_save :assign_role
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :role

  # Adds role to a new created user
  def assign_role
    self.role = Role.find_by name: "User" if self.role.nil?
  end

  def admin?
    self.role.name == "Admin"
  end

  def user?
    self.role.name == "User"
  end

  def guest?
    self.role.guest == "Guest"
  end

   attr_accessor :email, :password, :password_confirmation, :remember_me
end

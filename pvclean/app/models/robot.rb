class Robot < ActiveRecord::Base
  has_many :robot_infos
  has_and_belongs_to_many :routines
end

class RobotInfo < ActiveRecord::Base
  belongs_to :robot
  belongs_to :routine
end

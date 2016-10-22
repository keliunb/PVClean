class RoutineControl < ActiveRecord::Base
	has_and_belongs_to_many :robots
	has_many :routines
end

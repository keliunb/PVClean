class RoutineControl < ActiveRecord::Base
	has_and_belongs_to_many :robots
	has_many :routines

	WEEK_DAYS = Date::DAYNAMES.map {|l| l.downcase }
	
	def update_routine(week_days)
		puts week_days
		self.routines.each do |routine|
			routine.update(week_days)
		end
	end

end

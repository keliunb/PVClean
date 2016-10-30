class Routine < ActiveRecord::Base
	has_many :routine_results

	has_and_belongs_to_many :robots

	belongs_to :task

	WEEK_DAYS = Date::DAYNAMES.map {|l| l.downcase }

	def get_enable_days
		{ sunday: self.sunday,
		  monday: self.monday,
		  tuesday: self.tuesday,
		  wednesday: self.wednesday,
		  thursday: self.thursday,
		  friday: self.friday,
		  saturday: self.saturday
		}
	end

end

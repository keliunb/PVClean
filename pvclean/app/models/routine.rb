class Routine < ActiveRecord::Base
	belongs_to :routine_control
	has_many :routine_results

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

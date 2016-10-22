class Routine < ActiveRecord::Base
	belongs_to :routine_control
	has_many :routine_results
end

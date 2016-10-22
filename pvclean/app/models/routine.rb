class Routine < ActiveRecord::Base
	belongs_to :routine_control
	has_many :results
end

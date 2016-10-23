class ChangeRoutinesDayWeek < ActiveRecord::Migration
  def change
  	change_table :routines do |t|
	  t.remove :week_day
	  t.boolean :sunday
	  t.boolean :monday
	  t.boolean :tuesday
	  t.boolean :wednesday
	  t.boolean :thursday
	  t.boolean :friday
	  t.boolean :saturday
  	end
  end
end

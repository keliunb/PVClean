class RobotRoutineControl < ActiveRecord::Migration
  def change
    create_table :robots_routine_controls do |t|
      t.references :robot, index: true
      t.references :routine_control, index: true

      t.timestamps null: false
    end

  end
end

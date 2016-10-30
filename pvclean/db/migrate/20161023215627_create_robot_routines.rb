class CreateRobotRoutines < ActiveRecord::Migration
  def change
    create_table :robots_routines do |t|
      t.references :robot, index: true, foreign_key: true
      t.references :routine, index: true, foreign_key: true
    end
  end
end

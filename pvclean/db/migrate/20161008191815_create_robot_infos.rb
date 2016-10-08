class CreateRobotInfos < ActiveRecord::Migration
  def change
    create_table :robot_infos do |t|
      t.float :battery
      t.float :temperature
      t.float :humidity
      t.float :water
      t.string :position
      t.references :robot, index: true

      t.timestamps null: false
    end
  end
end

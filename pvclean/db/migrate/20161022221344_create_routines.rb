class CreateRoutines < ActiveRecord::Migration
  def change
    create_table :routines do |t|
      t.time :time
      t.integer :week_day
      t.references :routine_control, index: true 

      t.timestamps null: false
    end
  end
end



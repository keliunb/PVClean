class CreateRoutines < ActiveRecord::Migration
  def change
    create_table :routines do |t|
      t.time :time
      t.integer :week_day
      t.boolean :enable
      t.boolean :monthly

      t.boolean :sunday
      t.boolean :monday
      t.boolean :tuesday
      t.boolean :wednesday
      t.boolean :thursday
      t.boolean :friday
      t.boolean :saturday

      t.timestamps null: false
    end
  end
end



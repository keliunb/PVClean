class CreateRoutineControls < ActiveRecord::Migration
  def change
    create_table :routine_controls do |t|
      t.boolean :enabled
      t.boolean :monthly

      t.timestamps null: false
    end
  end
end

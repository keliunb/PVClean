class CreateRoutineResults < ActiveRecord::Migration
  def change
    create_table :routine_results do |t|
      t.datetime :date
      t.string :result
      t.references :routines, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

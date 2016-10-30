class AddReferencesToRoutine < ActiveRecord::Migration
  def change
    add_reference :routines, :task, index: true, foreign_key: true
  end
end

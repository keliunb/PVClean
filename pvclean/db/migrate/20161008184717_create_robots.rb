class CreateRobots < ActiveRecord::Migration
  def change
    create_table :robots do |t|
      t.integer :status
      t.string :identifier

      t.timestamps null: false
    end
  end
end

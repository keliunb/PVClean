class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password
      t.date :birth_date
      t.string :occupation
      t.string :graduation

      t.timestamps null: false
    end
  end
end

class CreateUsuarios < ActiveRecord::Migration
  def change
    create_table :usuarios do |t|
      t.string :nome
      t.date :idade
      t.string :cargo
      t.string :formacao

      t.timestamps null: false
    end
  end
end

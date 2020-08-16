class CreateTableDogs < ActiveRecord::Migration[5.2]
  def change
    create_table :dogs do |t|
      t.string :name
      t.string :breed
      t.integer :age
      t.string :sex
      t.string :description
      t.integer :owner_id
      t.timestamps null: false
    end
  end
end

class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :username
      t.string :password
      t.string :name
      t.string :lastname
      t.string :email
      t.integer :age
      t.boolean :covid

      t.timestamps
    end
  end
end

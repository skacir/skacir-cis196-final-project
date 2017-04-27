class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name
      t.boolean :car
      t.integer :number_of_seats
      t.string :email
      t.string :phone
      t.references :trip, foreign_key: true
      t.string :password_hash

      t.timestamps
    end
  end
end

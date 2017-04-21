class CreateTrips < ActiveRecord::Migration[5.0]
  def change
    create_table :trips do |t|
      t.references :user, foreign_key: true
      t.datetime :departure
      t.string :start_location
      t.string :end_location
      t.string :transit
      t.boolean :car
      t.integer :available_seats
      t.float :cost

      t.timestamps
    end
  end
end

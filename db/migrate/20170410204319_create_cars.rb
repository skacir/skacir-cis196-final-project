class CreateCars < ActiveRecord::Migration[5.0]
  def change
    create_table :cars do |t|
      t.references :user
      t.integer :seats

      t.timestamps
    end
  end
end

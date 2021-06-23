class CreateReservations < ActiveRecord::Migration[6.0]
  def change
    create_table :reservations do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone
      t.date :arrival_date
      t.date :departure_date
      t.integer :number_of_rooms, default: 1
      t.float :total
      t.references :hotel, null: false, foreign_key: true

      t.timestamps
    end
  end
end

class CreateHotels < ActiveRecord::Migration[6.0]
  def change
    create_table :hotels do |t|
      t.string :name
      t.string :city
      t.integer :number_of_rooms
      t.float :price
    end
  end
end

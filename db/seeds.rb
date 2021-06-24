# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

rand(10...20).times do
  Hotel.create!({
                  name: Faker::Company.name,
                  city: Faker::Address.city,
                  number_of_rooms: rand(50...200),
                  price: rand(25..250.0).round(2)
                })
end

rand(10...20).times do
  name = Faker::Name.first_name
  lastname = Faker::Name.last_name
  arrival = rand(Date.current...Date.current + 1.month)
  departure = rand(arrival+1.day...arrival + 2.weeks)
  Reservation.create!({
                        first_name: name,
                        last_name: lastname,
                        email: Faker::Internet.safe_email(name+" "+lastname),
                        phone:Faker::PhoneNumber.cell_phone,
                        arrival_date: arrival,
                        departure_date: departure,
                        number_of_rooms: rand(1...4),
                        hotel_id: Hotel.all.sample.id
                      })
end

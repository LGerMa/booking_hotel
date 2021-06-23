class Reservation < ApplicationRecord
  belongs_to :hotel

  scope :reservations_in_date, -> (date = Date.current) {
    where("arrival_date <= ? AND departure_date >= ?", date, date)
  }

  scope :by_hotel, -> (hotel_id) {
    where(hotel_id: hotel_id)
  }

  scope :reservations_in_progress_by_hotel, -> (hotel_id, date = Date.current) {
    by_hotel(hotel_id).reservations_in_date(date)
  }

  scope :rooms_unavailable_by_hotel, -> (hotel_id, date = Date.current) {
    reservations_in_progress_by_hotel(hotel_id, date).sum(:number_of_rooms)
  }

end

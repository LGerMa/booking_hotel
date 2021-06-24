class Reservation < ApplicationRecord
  belongs_to :hotel

  before_create :set_total
  before_update :set_total

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

  def full_name
    self.first_name+" "+self.last_name
  end

  def price_per_room
    self.total / self.number_of_rooms
  end

  private

    def set_total
      self.total = (self.number_of_rooms * self.hotel.price).round(2)
    end
end

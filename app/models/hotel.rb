class Hotel < ApplicationRecord
  has_many :reservations

  scope :search, -> (params) {
    #city, arrival_date, departure_date, number_of_rooms, max_price
    if(params["city"] &&
      params["arrival_date"] &&
      params["number_of_rooms"]
    )
      if(params["max_price"] != "")
        by_city(params["city"])
          .lower_than_price(params["max_price"])
          .current_available_in_date(params["number_of_rooms"], params["arrival_date"])
      else
        by_city(params["city"])
          .current_available_in_date(params["number_of_rooms"], params["arrival_date"])
      end
    else
      Hotel.all.order(:price)
    end
  }

  scope :by_city, -> (city = '') {
    city = city.downcase
    where("lower(city) LIKE ?", "%"+city+"%")
  }

  scope :lower_than_price, -> (price = 0) {
    where("price <= ?", price.to_f)
  }

  scope :current_available_in_date, -> (number_of_rooms = 0, date = Date.current) {
    unavailable = Reservation.select('COALESCE(sum(reservations.number_of_rooms),0)')
                             .where("arrival_date <= ? AND departure_date >= ?", date, date)
                             .where('reservations.hotel_id = hotels.id')
                             .to_sql
    select('*',
           "(#{unavailable}) unavailable",
           "number_of_rooms - (#{unavailable}) available"
    )
      .where('available >= ?', number_of_rooms.to_i)
      .order(:price)
  }

  def rooms_current_reserved
    Reservation.rooms_unavailable_by_hotel(self.id)
  end

  def rooms_current_available
    self.number_of_rooms - Reservation.rooms_unavailable_by_hotel(self.id)
  end


end

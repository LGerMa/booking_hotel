class ReservationsController < ApplicationController
  before_action :set_reservation, only: %i[ show edit update destroy ]

  include CustomValidation

  def index
    @reservation = Reservation.all
  end

  def show
  end

  def new
    hotel = Hotel.find(params["hotel_id"])
    hash_params = validate_params_q(params["q"])
    hash_params["hotel_id"] = params["hotel_id"]
    hash_params["total"] = (hash_params["number_of_rooms"].to_i * hotel.price).round(2)
    @reservation = Reservation.new(hash_params)
    @hotel = Hotel.find(params["hotel_id"])
    @messages = {message: ""}
    respond_to do |format|
      format.html { render :new,
                           reservation: @reservation,
                           hotel: @hotel,
                           messages: @messages
      }
    end
  end

  def edit
  end

  def create
    @reservation = Reservation.new(reservation_params)
    available = @reservation.hotel.number_of_rooms - Reservation.rooms_unavailable_by_hotel(@reservation.hotel_id, @reservation.arrival_date)
    if available >= 0 && @reservation.number_of_rooms <= available
      respond_to do |format|
        if @reservation.save
          format.html { redirect_to @reservation, notice: "Reservation was successfully created." }
          format.json { render :show, status: :created, location: @reservation }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @reservation.errors, status: :unprocessable_entity }
        end
      end
    else
      @hotel = @reservation.hotel
      @messages = { message: 'Hotel is full, search in new arrival date'}
      respond_to do |format|
        format.html { render :new ,
                             reservation: @reservation,
                             hotel: @hotel,
                             messages: @messages}
      end
    end

  end



  private
    def set_reservation
      @reservation = Reservation.find(params[:id])
    end

    def reservation_params
      params.require(:reservation).permit(:first_name, :last_name, :email, :phone, :arrival_date, :departure_date, :number_of_rooms, :hotel_id)
    end
end

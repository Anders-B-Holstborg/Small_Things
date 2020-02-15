class BookingsController < ApplicationController
  def index
  end

  def new
    @booking = Booking.new
  end

  def create(activity)
    @booking = Booking.create(user_id: current_user.id, activity_id: activity.id)
  end


  def accepted_activity
    @booking = current_user.bookings.find(params[:id])
    if @booking
      @booking.accepted
      @refused_booking = current_user.bookings.find_by(status: 'offered')
      @refused_booking.refused
      redirect_to dashboard_path(accepted_booking_id: @booking.id)
    else
      redirect_to dashboard_path
    end
  end

  def show
    @booking = find_booking
  end

  def edit
    @booking = find_booking
  end

  def update
  end

  private

  def find_booking
    @booking = Booking.find(params[:id])
  end
end

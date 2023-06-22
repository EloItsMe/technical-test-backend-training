class ListingsController < ApplicationController

  def index
    generate_mission
    @missions = missions_for_json
    render json: @missions
  end

  def show
    @mission = Mission.find_by(listing_id: params[:id])
    render json: @mission
  end

  private

  def generate_mission
    bookings = Booking.all
    bookings.each do |booking|
      first_checkin(booking)
      last_checkout(booking)
      checkout_checkin(booking) unless booking.listing.reservations.first.end_date == booking.end_date
    end
  end

  def first_checkin(booking)
    Mission.find_or_create_by!(
      listing_id: booking.listing_id,
      mission_type: 'first_checkin',
      date: booking.start_date,
      price: 10 * booking.listing.num_rooms
    )
  end

  def last_checkout(booking)
    Mission.find_or_create_by!(
      listing_id: booking.listing_id,
      mission_type: 'last_checkout',
      date: booking.end_date,
      price: 5 * booking.listing.num_rooms
    )
  end

  def checkout_checkin(booking)
    Mission.find_or_create_by!(
      listing_id: booking.listing_id,
      mission_type: 'checkout_checkin',
      date: booking.listing.reservations.first.end_date,
      price: 10 * booking.listing.num_rooms
    )
  end

  def missions_for_json
    missions = Mission.all
    {
      missions: [missions.map | mission | {
        listing_id: mission.listing_id,
        mission_type: mission.mission_type,
        date: mission.date,
        price: mission.price
      }]
    }
  end
end

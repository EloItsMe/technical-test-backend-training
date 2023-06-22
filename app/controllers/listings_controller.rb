class ListingsController < ApplicationController
  def index
    generate_mission
    @missions = missions_for_json
    render json: @missions
  end

  private

  def generate_mission
    bookings = Booking.all
    bookings.each do |booking|
      Mission.find_or_create_by!(listing_id: booking.listing_id, mission_type: 'first_checkin', date: booking.start_date, price: 10 * booking.listing.num_rooms)
      Mission.find_or_create_by!(listing_id: booking.listing_id, mission_type: 'last_checkout', date: booking.end_date, price: 5 * booking.listing.num_rooms)
      unless booking.listing.reservations.first.end_date == booking.end_date
        Mission.find_or_create_by!(listing_id: booking.listing_id, mission_type: 'checkout_checkin', date: booking.listing.reservations.first.end_date, price: 10 * booking.listing.num_rooms)
      end
    end
  end

  def missions_for_json
    missions = Mission.all
    {
      missions: [
        missions.map do |mission|
          { listing_id: mission.listing_id, mission_type: mission.mission_type, date: mission.date, price: mission.price }
        end
      ]
    }
  end
end

require 'system_helper'

RSpec.describe 'Rides index page', type: :system do
  let!(:customer) { Customer.create(email: 'location1', password: ) }
  let!(:ride1) { Ride.create(pickup_location: 'location1', customer: customer ) }

end
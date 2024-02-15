require 'system_helper'

RSpec.describe 'New ride page', type: :system do
  let!(:customer) { Customer.create(email: 'customer@test.com',
                                    password: '123456')}
  before do
    visit new_ride_path
    fill_in 'Email', with: 'customer@test.com'
    fill_in 'Password', with: customer.password
    click_on 'Log in'
  end

  it 'creating new ride' do
    expect(page).to have_selector('h1', text: 'New ride')
    expect(page).to have_field('Pickup location', type: 'text' )
    expect(page).to have_field('Dropoff location', type: 'text' )
    fill_in 'Pickup location', with: '15 The Gates'
    fill_in 'Dropoff location', with: '9 Windgates'
    click_on 'Create Ride'

    expect(Ride.count).to eq(1)
    expect(current_path).to eq(ride_path(Ride.last.id))
    expect(page).to have_css('.notice', text: 'Ride was successfully created.')

    click_on 'Back to rides'
    expect(current_path).to eq('/rides')
  end
end
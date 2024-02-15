require 'system_helper'

RSpec.describe 'Customer rides list page', type: :system do
  let!(:customer) { Customer.create(email: 'customer@test.com', password: '123456') }
  let!(:ride1) { Ride.create(pickup_location: 'location1', dropoff_location: 'destination1', customer: customer)}
  let!(:ride2) { Ride.create(pickup_location: 'location2', dropoff_location: 'destination2', customer: customer)}


  before do
    visit '/rides'
    fill_in 'Email', with: 'customer@test.com'
    fill_in 'Password', with: '123456'
    click_on "Log in"
  end

  it 'checking new ride button' do
    click_on 'New ride'
    expect(current_path).to eq(new_ride_path)
  end

  it 'checking new ride list' do
    expect(page).to have_selector('h1', text: 'Rides')
    expect(page).to have_selector('p', text: 'Pickup location')
    expect(page).to have_selector('p', text: 'Dropoff location')
    expect(page).to have_selector('p', text: 'Customer')
    expect(page).to have_selector('p', text: 'Status')
    rides_show_buttons=find_all('a', text: 'Show this ride')
    expect(rides_show_buttons.size).to eq(2)
    # expect(page).to have_css('a', text: 'Show this ride')
    rides_edit_buttons=find_all('a', text: 'Edit this ride')
    expect(rides_edit_buttons.size).to eq(2)
    # expect(page).to have_css('a', text: 'Edit this ride')
    expect(page).to have_css('button', text: 'Log out')
  end

  it 'checking show this ride button' do
    find('a', text: 'Show this ride', match: :first).click

    expect(current_path).to eq("/rides/#{Ride.first.id}")
  end

  it 'checking edit this ride button' do
    find('a', text: 'Edit this ride', match: :first).click

    expect(current_path).to eq("/rides/#{ride1.id}/edit")
  end
end

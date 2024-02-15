require 'system_helper'

RSpec.describe 'Customer sign up page', type: :system do

  before do
    visit new_customer_registration_path
  end

  it 'has title with respective text' do
    expect(page).to have_selector('h2', text: 'Customer Sign Up')
  end

  it 'has three inputs to enter customer email, password and password confirmation ' do
    expect(page).to have_field('Email', type: 'email' )
    expect(page).to have_css('input#customer_password')
    expect(page).to have_field('Password confirmation', type: 'password')
  end

  it 'signs up a visitor as a customer with valid inputs' do
    fill_in 'Email', with: 'user@example.com'
    fill_in 'Password', with: '123456'
    fill_in 'Password confirmation', with: '123456'
    click_on 'Sign up'
    expect(page).to have_css('.notice', text: 'Welcome! You have signed up successfully.')
    expect(Customer.count).to eq(1)
    expect(Customer.last.email).to eq('user@example.com')
    expect(page).to have_css('h1', text: 'Ruber')
    expect(page).to have_css('a', text: 'Request New Ride')
    expect(page).to have_css('p', text: 'A ride sharing app')
    expect(current_path).to eq(root_path)

    click_on 'Request New Ride'

    expect(current_path).to eq(new_ride_path)
  end

  it 'does not sign up a visitor as a customer with invalid inputs' do
    fill_in 'Email', with: ''
    fill_in 'Password', with: '123456'
    fill_in 'Password confirmation', with: '123456'
    click_on 'Sign up'
    expect(page).to have_content('1 error')
  end
end

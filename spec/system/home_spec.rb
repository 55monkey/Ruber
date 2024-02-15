require 'system_helper'

RSpec.describe 'Home page', type: :system do

  before do
    visit root_path
  end

  it 'has a title with correct text' do
    expect(page).to have_selector('h1', text: 'Ruber')
  end

  it 'has expected text as a paragraph under title' do
      expect(page).to have_content('A ride sharing app built on Ruby on Rails and Hotwire!')
  end

  it 'leads to new customer registration page when sign up button is clicked' do
      click_on "Sign Up as Customer"
      expect(current_path).to eq(new_customer_registration_path)
  end

  it 'leads to new driver registration page when that sign up button is clicked' do
    click_on "Sign Up as Driver"
    expect(current_path).to eq(new_driver_registration_path)
  end

  it 'has link to sign up as a customer' do
    expect(page).to have_selector('a', text: 'Sign Up as Customer')
  end

  it 'has a link to sign up as a driver' do
    expect(page).to have_selector('a', text: 'Sign Up as Driver')
  end

end

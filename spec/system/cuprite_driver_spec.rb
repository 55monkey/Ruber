require 'system_helper'

RSpec.describe 'Cuprite driver', type: :system do
  it 'works' do
    visit 'https://example.com:443'
    sleep 3
    within('h1') do
      expect(page).to have_content('Example Domain')
    end
  end
end

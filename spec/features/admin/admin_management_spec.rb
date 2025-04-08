require 'rails_helper'

RSpec.feature "Dashboard Manage Donations", type: :feature do
  let!(:donations) { create_list(:donation, 3) } # Creates 3 sample donations

  scenario "displays the Manage Donations card and navigates to donations list" do
    visit admin_dashboard_path

    within(".action-card") do
      expect(page).to have_content("Manage Donations")
      expect(page).to have_content("View all Available donation")
      expect(page).to have_link("View Donations", href: donations_path)

      click_link "View Donations"
    end

    expect(current_path).to eq(donations_path)

    donations.each do |donation|
      expect(page).to have_content(donation.title)
    end
  end
end

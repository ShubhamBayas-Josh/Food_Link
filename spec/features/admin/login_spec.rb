require 'rails_helper'

RSpec.feature "Admin Login", type: :feature do
  let!(:admin) { Admin.create(email: "shubhambayas7@gmail.com", password: "1234567890") }

  scenario "Admin logs in successfully and sees welcome message" do
    visit new_admin_session_path

    fill_in placeholder: "Enter your email", with: admin.email
    fill_in placeholder: "Enter your password", with: admin.password

    click_button "Log In"

    # Expectation: Page should have the welcome message
    expect(page).to have_content("Welcome Back!")
    expect(page).to have_selector("p", text: "Login to your account")
  end
end

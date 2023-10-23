require 'rails_helper'

RSpec.describe "Logging In" do
  it "can log in with valid credentials" do
    user = User.create(name: 'User One', email: 'notunique@example.com', password: "test", password_confirmation: "test")

    visit root_path

    click_on "I already have an account"

    expect(current_path).to eq(login_path)
    
    fill_in :name, with: user[:name]
    fill_in :password, with: user.password

    click_on "Log In"

    expect(current_path).to eq(root_path)

    expect(page).to have_content("Welcome!")
  end
end
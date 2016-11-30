require 'spec_helper'

describe "User session integration tests", js: true do

  let!(:user) { FactoryGirl.create(:user)  }

  it "user can create a new account" do
    visit new_user_registration_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    fill_in "Password confirmation", with: user.password_confirmation
    click_button "Sign up"
    expect(page).to have_text("Logout")
    expect(page).to have_text("Please rate more movies to receive recommendations!")
  end

  it "user cannot create account if password is not confirmed" do
    visit new_user_registration_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign up"
    expect(page).to have_text("Sign up")
  end

  it "User can login and start session" do
    visit new_user_session_path
    expect(page).to have_text("Sign in")
    expect(page).to have_text("Email")
    expect(page).to have_text("Password")
    expect(page).to have_text("Sign up")
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign in"
    expect(page).to have_content 'Recommendations'
  end

  it "User can't start session with wrong password" do
    visit new_user_session_path
    expect(page).to have_text("Sign in")
    expect(page).to have_text("Email")
    expect(page).to have_text("Password")
    expect(page).to have_text("Sign up")
    fill_in "Email", with: user.email
    fill_in "Password", with: 'fake-password'
    click_button "Sign in"
    expect(page).to have_content 'Invalid email or password.'
  end

  it "User can't begin session with wrong email" do
    visit new_user_session_path
    expect(page).to have_text("Sign in")
    expect(page).to have_text("Email")
    expect(page).to have_text("Password")
    expect(page).to have_text("Sign up")
    fill_in "Email", with: 'fake-email@fake.com'
    fill_in "Password", with: 'fake-password'
    click_button "Sign in"
    expect(page).to have_content 'Invalid email or password.'
  end

  it "User can log out when they have an active session" do
    login(user)
    visit destroy_user_session_path
    expect(page).to have_text("Signed out successfully.")
  end

  it "User can update their email" do
    login(user)
    visit edit_user_registration_path
    fill_in "Name", with: user.name
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    fill_in "Password", with: user.password_confirmation
    click_button "Update"
    expect(page).to have_text("Recommendations")
  end

  it "User can cancel their account" do
    login(user)
    visit edit_user_registration_path
    click_link('Cancel my account')
    alert = page.driver.browser.switch_to.alert
    alert.accept
    expect(page).to have_text("Bye! Your account was successfully cancelled. We hope to see you again soon.")
  end

end

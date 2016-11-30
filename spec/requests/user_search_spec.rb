require 'spec_helper'

describe "User search bar integration tests", js: true do

  let!(:user) { FactoryGirl.create(:user)  }

  before(:each) do
    login(user)
  end

  it "user can see the search bar on every page except 'Edit User' " do
    visit recommendations_path
    expect(page).to have_text("Search")

    visit user_ratings_path
    expect(page).to have_text("Search")

    visit edit_user_registration_path
    expect(page).to_not have_text("Search")
  end

end

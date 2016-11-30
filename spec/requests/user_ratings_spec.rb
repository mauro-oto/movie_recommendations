require 'spec_helper'

describe "User ratings integration tests", js: true do

  let!(:user) { FactoryGirl.create(:user)  }

  before(:each) do
    login(user)
  end

  it "user can see their ratings page" do
    visit user_ratings_path
    element = find('a.selected')
    element[:href].ends_with?("/users/ratings").should be_true
  end
end

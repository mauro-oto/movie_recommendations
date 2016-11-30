require 'spec_helper'

describe "Visitor (unauthenticated user) integration behavior", js: true do 

  it "unauthenticated user cannot see ratings page" do
    visit ratings_path
    expect(page).to have_text("You need to sign in or sign up before continuing.")
  end

  it "unauthenticated user cannot see user ratings page" do
    visit ratings_path
    expect(page).to have_text("You need to sign in or sign up before continuing.")
  end

  it "unauthenticated user cannot see recommendations page" do
    visit ratings_path
    expect(page).to have_text("You need to sign in or sign up before continuing.")
  end

  it "unauthenticated user cannot see search bar" do 
    visit root_path
    expect(page).to_not have_text("Search")
  end

end

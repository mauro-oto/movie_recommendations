require 'spec_helper'

describe Genre do

  before (:each) do
    @genre = FactoryGirl.build(:genre)
  end

  describe "validations" do
    it "should save with a valid name" do
      @genre.save
      expect(Genre.count).to eq(1)
    end

    it "should not save with empty name field" do 
      @genre.name = ""
      @genre.save
      expect(Genre.count).to eq(0)
    end
  end

end

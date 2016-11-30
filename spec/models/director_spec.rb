require 'spec_helper'

describe Director do

  before(:each) do
    @director = FactoryGirl.build(:director)
  end

  describe "validations" do
    it "should save with a valid name" do
      @director.save
      expect(Director.count).to eq(1)
    end

    it "should not save with empty name field" do
      @director.name = ""
      @director.save
      expect(Director.count).to eq(0)
    end
  end

end

require 'spec_helper'

describe Actor do

  before (:each) do
    @actor = FactoryGirl.build(:actor)
  end

  describe "validations" do
    it "should save with a valid name" do
      @actor.save
      expect(Actor.count).to eq(1)
    end

    it "should not save with empty name field" do 
      @actor.name = ""
      @actor.save
      expect(Actor.count).to eq(0)
    end
  end

end

require 'spec_helper'

describe Recommendation do

  describe "validations" do
    before(:each) do
      @recommendation = FactoryGirl.build(:recommendation)
    end

    it "should save with valid information" do
      @recommendation.save
      expect(Recommendation.count).to eq(1)
    end

    it "should not save without a movie_id" do
      @recommendation.movie_id = nil
      @recommendation.save
      expect(Recommendation.count).to eq(0)
    end

    it "should not save without a user_id" do
      @recommendation.user_id = nil
      @recommendation.save
      expect(Recommendation.count).to eq(0)
    end

    it "should not allow a movie to be recommended twice" do
      @recommendation.save
      expect { FactoryGirl.create(:recommendation) }.to raise_error
    end
  end

end

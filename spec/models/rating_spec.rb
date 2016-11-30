require 'spec_helper'

describe Rating do

  describe "validations" do
    before (:each) do
      @rating = FactoryGirl.build(:rating)
    end

    it "should save with a valid rating" do
      @rating.save
      expect(Rating.count).to eq(1)
    end

    it "should not save with empty rating_value field" do 
      @rating.rating_value = nil
      @rating.save
      expect(Rating.count).to eq(0)
    end

    it "should not save with empty movie_id field" do 
      @rating.movie_id = nil
      @rating.save
      expect(Rating.count).to eq(0)
    end

    it "should not save with empty user_id field" do 
      @rating.user_id = nil
      @rating.save
      expect(Rating.count).to eq(0)
    end

    it "should not save with a rating value below 1" do
      @rating.rating_value = 0
      @rating.save
      expect(Rating.count).to eq(0)
    end

    it "should not save with a rating value over 5" do 
      @rating.rating_value = 6
      @rating.save
      expect(Rating.count).to eq(0)
    end

    it "should not save if the movie_id and user_id are the same as one in the DB" do 
      FactoryGirl.create(:rating)
      @rating.save
      expect(Rating.count).to eq(1)
    end

    it "should allow a rating to be updated" do 
      @rating.save
      @rating.rating_value = 3
      @rating.save
      expect(Rating.find(1).rating_value).to eq(3)
    end

    it "should not allow a rating to be updated if rating_value is above 5" do 
      @rating.save
      @rating.rating_value = 6
      @rating.save
      expect(Rating.find(1).rating_value).to eq(5)
    end

    it "should not allow a rating to be updated if rating_value is below 0" do 
      @rating.save
      @rating.rating_value = 0
      @rating.save
      expect(Rating.find(1).rating_value).to eq(5)
    end
  end

end

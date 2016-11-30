require 'spec_helper'

describe PearsonCorrelation, type: :service do
  subject { described_class }

  describe "#calculate" do
    let!(:users) { FactoryGirl.create_list(:user, 4) }
    let!(:movies) do
      FactoryGirl.create_list(:movie, 5, :with_actor_director_and_genre)
    end
    let(:user_0_ratings) do
      users[0].ratings << Rating.create(movie_id: movies[1].id, rating_value: 5)
      users[0].ratings << Rating.create(movie_id: movies[2].id, rating_value: 5)
      users[0].ratings << Rating.create(movie_id: movies[3].id, rating_value: 3)
      users[0].ratings << Rating.create(movie_id: movies[4].id, rating_value: 5)
    end
    let(:user_1_ratings) do
      users[1].ratings << Rating.create(movie_id: movies[0].id, rating_value: 5)
    end
    let(:user_2_ratings) do
      users[2].ratings << Rating.create(movie_id: movies[1].id, rating_value: 5)
      users[2].ratings << Rating.create(movie_id: movies[2].id, rating_value: 4)
      users[2].ratings << Rating.create(movie_id: movies[3].id, rating_value: 3)
      users[2].ratings << Rating.create(movie_id: movies[4].id, rating_value: 3)
    end
    let(:user_3_ratings) do
      users[3].ratings << Rating.create(movie_id: movies[1].id, rating_value: 5)
      users[3].ratings << Rating.create(movie_id: movies[2].id, rating_value: 5)
      users[3].ratings << Rating.create(movie_id: movies[3].id, rating_value: 3)
      users[3].ratings << Rating.create(movie_id: movies[4].id, rating_value: 5)
    end
    let(:user_3_ratings_alt) do
      users[3].ratings << Rating.create(movie_id: movies[1].id, rating_value: 1)
      users[3].ratings << Rating.create(movie_id: movies[2].id, rating_value: 1)
      users[3].ratings << Rating.create(movie_id: movies[3].id, rating_value: 3)
      users[3].ratings << Rating.create(movie_id: movies[4].id, rating_value: 1)
    end

    context "one of the users has no ratings" do
      before { user_1_ratings }

      it "returns zero" do
        pearson_corr = subject.new(users[0], users[1]).calculate
        expect(pearson_corr).to eq(0)
      end
    end

    context "users have no movies in common" do
      before do
        user_1_ratings
        user_2_ratings
      end

      it "returns zero" do
        pearson_corr = subject.new(users[1], users[2]).calculate
        expect(pearson_corr).to eq(0)
      end
    end

    context "users have similar ratings" do
      before do
        user_2_ratings
        user_3_ratings
      end

      it "returns a value closer to 1" do
        pearson_corr = subject.new(users[2], users[3]).calculate
        expect(pearson_corr).to be_between(-1, 1)
      end
    end

    context "users have the same ratings" do
      before do
        user_0_ratings
        user_3_ratings
      end

      it "returns 1" do
        pearson_corr = subject.new(users[0], users[3]).calculate
        expect(pearson_corr).to eq 1
      end
    end

    context "users have opposite ratings" do
      before do
        user_0_ratings
        user_3_ratings_alt
      end

      it "returns -1" do
        pearson_corr = subject.new(users[0], users[3]).calculate
        expect(pearson_corr).to eq -1
      end
    end
  end
end

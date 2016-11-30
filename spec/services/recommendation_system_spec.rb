require 'spec_helper'

describe RecommendationSystem, type: :service do
  let(:user) { FactoryGirl.create(:user) }
  let(:movie_count) { 10 }
  let(:actor) { FactoryGirl.create(:actor, name: "Jean Claude Van Damme") }
  let(:director) { FactoryGirl.create(:director, name: "Stanley Kubrick") }
  let(:genre) { FactoryGirl.create(:genre, name: "Comedy") }
  let(:movies) { FactoryGirl.create_list(:movie, movie_count) }
  let(:rating) do
    FactoryGirl.create(:rating, user_id: user.id, movie_id: movies[0].id,
                                rating_value: rating_value)
  end
  subject { described_class.new(rating) }

  before do
    movies.each do |movie|
      movie.genres << genre
      movie.actors << actor
      movie.directors << director
    end
  end

  context 'Unit Cluster' do
    let(:cluster) { subject.unit_cluster }

    context "if a rating of 5 is given" do
      let(:rating_value) { 5 }

      it "returns movie ids for movies with same director, actor and genre" do
        expect(cluster).to include(movies[1].id, movies[2].id, movies[3].id)
      end

      it "returns a list of max length 30" do
        expect(cluster.length).to(
          be_between(movie_count - 1, RECOMMENDATION_LIMITS[rating_value]))
      end
    end

    context "if a rating of 4 is given" do
      let(:rating_value) { 4 }

      it "returns a list of max length 20" do
        expect(cluster.length).to(
          be_between(movie_count - 1, RECOMMENDATION_LIMITS[rating_value]))
      end
    end

    context "if a rating of 3 is given" do
      let(:rating_value) { 3 }

      it "returns a list of max length 10" do
        expect(cluster.length).to(
          be_between(movie_count - 1, RECOMMENDATION_LIMITS[rating_value]))
      end
    end
  end
end

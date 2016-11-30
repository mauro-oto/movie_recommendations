FactoryGirl.define do

  factory :actor do
    sequence(:name) {|n| "Actor#{n}" }
  end

  factory :director do
    sequence(:name) {|n| "Director#{n}" }
  end

  factory :genre do
    sequence(:name) {|n| "Genre#{n}" }
  end

  factory :movie do
    title { Faker::Company.name }

    trait :with_actor_director_and_genre do
      actors { [FactoryGirl.create(:actor)] }
      directors { [FactoryGirl.create(:director)] }
      genres { [FactoryGirl.create(:genre)] }
    end
  end

end

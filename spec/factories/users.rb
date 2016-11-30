FactoryGirl.define do
  factory :user do
    sequence(:name) {|n| "person#{n}" }
    sequence(:email) {|n| "person#{n}@example.com" }
    password '123456789'
    password_confirmation '123456789'
  end
end

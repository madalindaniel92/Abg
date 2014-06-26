# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "Daniel #{n}" }
    sequence(:username) { |n| "darkdaniel#{n}" }     
    sequence(:email) { |n| "darkdaniel#{n}@gmail.com" }
    password "isneeded"
    password_confirmation "isneeded"

    factory :admin  do
      admin  true
    end
  end
end

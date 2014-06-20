# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name "Madalin Daniel"
    username "darkdaniel"
    email "darkdaniel@gmail.com"
    password "isneeded"
    password_confirmation "isneeded"
  end
end

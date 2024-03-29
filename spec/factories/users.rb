# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do

    factory :first_user do
      name "User Name"
      phone 8018018001
      password 'supersecret'
      sequence(:email) {|n| "user+#{n}@email.com"}
    end

    factory :login_user do
      name "username"
      phone 8018018001
      password 'password'
      password_confirmation 'password'
      sequence(:email) {|n| "username+#{n}@email.com"}
    end

    factory :invalid_user do
      name "username"
      phone 'bill'
      password 'nope'
      sequence(:email) {|n| "username+#{n}@email.com"}
    end
  end
end

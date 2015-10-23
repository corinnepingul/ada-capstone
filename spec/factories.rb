FactoryGirl.define do
  factory :user do
    username "corinnepingul"
    email "corinnepingul@gmail.com"
    password "corinnepingul"
    password_confirmation "corinnepingul"
    country_code "1"
    phone_number "+11111111111"
    locale "en"
    verified true
  end

  factory :moment do
    date Date.new(1992, 9, 14)
    body "This is when I was born. #imhere"
    user # could pass in params here
    media_url nil
  end

  factory :tag do
    body "#imhere"
  end
end

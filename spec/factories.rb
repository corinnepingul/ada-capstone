FactoryGirl.define do
  factory :user do
    username "corinnepingul"
    email "corinnepingul@gmail.com"
    password_digest "corinnepingul"
    phone_number 1111111111
    locale "en"
  end

  factory :moment do
    date Date.new(1992, 9, 14)
    body "This is when I was born. #imhere"
    user
  end

  factory :tag do
    body "#imhere"
  end
end

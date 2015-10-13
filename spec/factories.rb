FactoryGirl.define do
  factory :user do
    username "corinnepingul"
    email "corinnepingul@gmail.com"
    password_digest "corinnepingul"
    phone_number 1111111111
    locale "en"
  end

  factory :moment do
    date "09/14/1992"
    body "This is when I was born. #imhere"
    user
  end

  factory :tag do
    body "#imhere"
  end
end

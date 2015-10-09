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
    user_id 1

    after(:build) do |moment|
      tag = create(:tag) # create a new tag
      moment.user = create(:user) # associate user with moment
      moment.tags << [tag] # associate tag with moment
      moment.user.tags << [tag] # associate tag with user
    end
  end

  factory :tag do
    body "#imhere"

    after(:build) do |tag|
      tag.users << [create(:user)] # associates tag with user
      tag.moments << [create(:moment)] # associates tag with moment
    end
  end
end

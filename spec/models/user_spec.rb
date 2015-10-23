require 'rails_helper'

RSpec.describe User, type: :model do
  # TODO: user model association tests
  describe "user model associations" do
    it "has and belongs to many tags" do

    end

    it "has many moments" do

    end
  end

  describe "user model validations" do
    let(:user) { create(:user) }

    it "is valid" do
      expect(user).to be_valid
    end

    it "requires a unique username" do
      user
      user_without_username = build(:user, username: nil) # invalid user (no name)
      user_without_unique_username = build(:user) # invalid user (non-unique name)

      expect(user_without_username).to_not be_valid
      expect(user_without_unique_username).to_not be_valid
    end

    it "requires a unique email" do
      user
      user_without_email = build(:user, email: nil) # invalid user (no email)
      user_without_unique_email = build(:user) # invalid user (non-unique email)

      expect(user_without_email).to_not be_valid
      expect(user_without_unique_email).to_not be_valid
    end

    it "requires a password" do
      user_without_password = build(:user, password_digest: nil)

      expect(user_without_password).to_not be_valid
    end

    it "requires a unique phone number" do
      user # valid user
      user_without_phone_number = build(:user, phone_number: nil) # invalid user (no phone_number)
      user_without_unique_phone_number = build(:user) # invalid user (non-unique phone_number)

      expect(user_without_phone_number).to_not be_valid
      expect(user_without_unique_phone_number).to_not be_valid
    end

    it "requires a phone number to be a length between 10 and 15" do
      user_with_short_number = build(:user, phone_number: "123456789")
      user_with_long_number = build(:user, phone_number: "1234567891123456")

      expect(user_with_short_number).to_not be_valid
      expect(user_with_long_number).to_not be_valid
    end

    it "does not require a locale" do
      user_without_locale = build(:user, locale: nil)

      expect(user_without_locale).to be_valid
    end
  end
end

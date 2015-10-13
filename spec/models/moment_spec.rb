require 'rails_helper'

RSpec.describe Moment, type: :model do
  describe "moment model associations" do
    it "belongs to a user" do

    end

    it "has and belongs to many tags" do

    end
  end

  describe "moment model validations" do
    let(:moment) { create(:moment) }

    it "is valid" do
      expect(moment).to be_valid
    end

    it "requires a date" do
      moment_without_date = build(:moment, date: nil) # invalid moment (no date)

      expect(moment_without_date).to_not be_valid
    end

    it "requires a body" do
      moment_without_body = build(:moment, body: nil) # invalid moment (no body)

      expect(moment_without_body).to_not be_valid
    end

    it "requires a user_id" do
      moment_without_user_id = build(:moment, user_id: nil) # invalid moment (no user_id)

      expect(moment_without_user_id).to_not be_valid
    end
  end
end

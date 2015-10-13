require 'rails_helper'

RSpec.describe Tag, type: :model do
  # TODO: tag model association tests
  describe "tag model associations" do
    it "has and belongs to many users" do

    end

    it "has and belongs to many moments" do

    end
  end

  describe "tag model validations" do
    let(:tag) { create(:tag) }

    it "is valid" do
      expect(tag).to be_valid
    end

    it "requires a body" do
      tag_without_body = build(:tag, body: nil) # invalid tag (no body)

      expect(tag_without_body).to_not be_valid
    end
  end
end

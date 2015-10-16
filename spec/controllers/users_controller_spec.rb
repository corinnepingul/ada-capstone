require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "POST #create" do
    context "no username" do
      before :each do
        post :create, user: attributes_for(:user, username: "")
      end

      it "doesn't persist the user to the db" do
        expect(User.count).to eq 0
      end

      it "redirects_to registration_path" do
        expect(subject).to redirect_to(registration_path)
      end

      it "assigns flash[:errors]" do
        expect(flash[:errors]).to include { :registration_error }
      end
    end

    context "duplicate username" do
      before :each do
        create(:user)
        post :create, user: attributes_for(:user, phone_number: 1234567123, email: "different@gmail.com")
      end

      it "doesn't persist the user to the db" do
        expect(User.all.count).to eq 1
        expect(User.where(username: "corinnepingul").count).to eq 1
      end

      it "redirects_to registration_path" do
        expect(subject).to redirect_to(registration_path)
      end

      it "assigns flash[:errors]" do
        expect(flash[:errors]).to include { :registration_error }
      end
    end

    context "duplicate phone number" do
      before :each do
        create(:user)
        post :create, user: attributes_for(:user, username: "different", email: "different@gmail.com")
      end

      it "doesn't persist the user to the db" do
        expect(User.all.count).to eq 1
        expect(User.where(phone_number: 1111111111).count).to eq 1
      end

      it "redirects_to registration_path" do
        expect(subject).to redirect_to(registration_path)
      end

      it "assigns flash[:errors]" do
        expect(flash[:errors]).to include { :registration_error }
      end
    end

    context "duplicate email" do
      before :each do
        create(:user)
        post :create, user: attributes_for(:user, username: "different", phone_number: 1234567123)
      end

      it "doesn't persist the user to the db" do
        expect(User.all.count).to eq 1
        expect(User.where(email: "corinnepingul@gmail.com").count).to eq 1
      end

      it "redirects_to registration_path" do
        expect(subject).to redirect_to(registration_path)
      end

      it "assigns flash[:errors]" do
        expect(flash[:errors]).to include { :registration_error }
      end
    end

    context "invalid password and password confirmation (do not match)" do
      before :each do
        post :create, user: attributes_for(:user, password_confirmation: "wrong")
      end

      it "doesn't persist the user to the db" do
        expect(User.count).to eq 0
      end

      it "redirects_to registration_path" do
        expect(subject).to redirect_to(registration_path)
      end

      it "assigns flash[:errors]" do
        expect(flash[:errors]).to include { :registration_error }
      end
    end

    context "valid new user" do
      before :each do
        post :create, user: attributes_for(:user)
      end

      it "adds the new user to the db" do
        expect(User.count).to eq 1
      end

      it "redirects to the users homepage" do
        expect(subject).to redirect_to root_path
      end

      it "signs them into a session" do
        expect(session[:id]).to eq User.first.id
      end
    end
  end
end

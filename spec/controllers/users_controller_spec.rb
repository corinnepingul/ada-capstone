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

      it "renders the sessions#new view" do
        expect(subject).to render_template "sessions/new"
      end

      it "assigns flash.now[:errors]" do
        expect(flash.now[:errors]).to include { :registration_error }
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

      it "renders the sessions#new view" do
        expect(subject).to render_template "sessions/new"
      end

      it "assigns flash.now[:errors]" do
        expect(flash.now[:errors]).to include { :registration_error }
      end
    end

    context "duplicate phone number" do
      before :each do
        create(:user)
        post :create, user: attributes_for(:user, phone_number: "1111111111", username: "different", email: "different@gmail.com")
      end

      it "doesn't persist the user to the db" do
        expect(User.all.count).to eq 1
        expect(User.where(phone_number: "+11111111111").count).to eq 1
      end

      it "renders the sessions#new view" do
        expect(subject).to render_template "sessions/new"
      end

      it "assigns flash.now[:errors]" do
        expect(flash.now[:errors]).to include { :registration_error }
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

      it "renders the sessions#new view" do
        expect(subject).to render_template "sessions/new"
      end

      it "assigns flash.now[:errors]" do
        expect(flash.now[:errors]).to include { :registration_error }
      end
    end

    context "invalid password and password confirmation (do not match)" do
      before :each do
        post :create, user: attributes_for(:user, password_confirmation: "wrong")
      end

      it "doesn't persist the user to the db" do
        expect(User.count).to eq 0
      end

      it "renders the sessions#new view" do
        expect(subject).to render_template "sessions/new"
      end

      it "assigns flash.now[:errors]" do
        expect(flash.now[:errors]).to include { :registration_error }
      end
    end

    context "valid new user" do
      before :each do
        post :create, user: attributes_for(:user)
      end

      it "adds the new user to the db" do
        expect(User.count).to eq 1
      end

      it "redirects to the verification page" do
        expect(subject).to redirect_to verify_path
      end

      it "signs them into a session" do
        expect(session[:id]).to eq User.first.id
      end
    end
  end

  describe "GET #show_verify" do
    context "user is signed in" do
      before :each do
        @user = create(:user, verified: false)
        session[:id] = @user.id

        get :show_verify
      end

      it "renders the show_verify view" do
        expect(response).to render_template :show_verify
      end
    end

    context "no user signed in" do
      before :each do
        @user = create(:user, verified: false)
        session[:id] = nil

        get :show_verify
      end

      it "redirects to registration_path" do
        expect(response).to redirect_to registration_path
      end
    end
  end

  describe "POST #verify" do

    context "Authy token is valid" do
      before :each do
        @user = create(:user, verified: false)
        session[:id] = @user.id

        post :verify
      end

      it "updates the users verfied column to true" do

      end

      it "sets flash message to successful_login" do

      end

      it "redirects_to the root_path" do

      end
    end

    context "Authy token is invalid" do
      it "sets flash error message to incorrect_verification_code" do

      end

      it "rerenders the show_verify page" do

      end
    end
  end

  describe "POST #resend" do

  end
end

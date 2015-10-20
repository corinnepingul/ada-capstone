require 'rails_helper'

RSpec.describe WelcomeController, type: :controller do
  describe "GET index" do
    context "user not logged in" do
      it "requires login by redirecting to login page" do
        session[:id] = nil
        get :index

        expect(response).to redirect_to(registration_path)
      end
    end

    context "user logged in, but not verified" do
      before :each do
        @user = create(:user, verified: false)
        session[:id] = @user.id
        get :index
      end

      it "loads the verification page" do
        expect(response).to redirect_to(verify_path)
      end
    end

    context "user logged in and verified" do
      before :each do
        @user = create(:user)
        session[:id] = @user.id
        get :index
      end

      it "loads the homepage" do
        expect(response).to render_template(:index)
      end

      it "assigns the signed in user" do
        expect(assigns(:user)).to eq @user
      end

      it "assigns the signed in user's posts" do
        expect(assigns(:moments)).to eq @user.moments
      end
    end
  end
end

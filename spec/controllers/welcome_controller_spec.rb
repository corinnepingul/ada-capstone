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

    context "user logged in" do

    end
  end
end

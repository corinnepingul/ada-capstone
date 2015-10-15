require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe "GET #index" do
    it "does not require login" do
      session[:id] = nil
      get :index

      expect(flash[:error]).to be_nil
      expect(response).not_to redirect_to(registration_path)
    end

    it "renders the index template" do
      get :index

      expect(response).to render_template("index")
    end
  end

  describe "POST #create" do
    context "valid user params" do
      let(:user_login_params) { { :session => attributes_for(:user) } }

      before :each do
        @user = create(:user)

        post :create, user_login_params
      end

      it "sets the user" do
        expect(assigns(:user)).to eq @user
      end

      it "sets session[:id] to the user's id" do
        expect(session[:id]).to eq @user.id
      end

      it "updates the flash[:messages] to include :successful_login" do
        expect(flash[:messages]).to include { :successful_login }
      end

      it "redirects to the user's homepage" do
        expect(response).to redirect_to root_path(@user.id)
        expect(response).to have_http_status(302)
      end
    end
  end
end

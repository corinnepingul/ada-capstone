require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe "GET #index" do
    it "does not require login" do
      session[:id] = nil
      get :index

      expect(flash[:error]).to be_nil
      expect(response).not_to redirect_to(login_path)
    end

    # it "renders the index template" do
    #   get :index
    #
    #   expect(response).to render_template("index")
    # end
  end
end

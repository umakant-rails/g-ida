require "spec_helper"

describe ResponsesController do
  
  describe "GET #index" do
    let(:user) { FactoryGirl.create(:user) }
    before { sign_in user }
    it "responds successfully for index method with an HTTP 200 status code" do
      get :index
      expect(response).to be_success
      expect(response.status).to eq(200)
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end

end

require "spec_helper"

describe AnswersController do
  
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

    it "loads all of the answer into @answers" do
      10.times{ Answer.create! }
      answers = Answer.all
      get :index
      expect(assigns(:answers)).to match_array(answers)
    end
  end

  describe "GET #show" do
    
    let(:user) { FactoryGirl.create(:user) }
    before { sign_in user }
    params = {}
    params[:poll] =  {"title"=>"Politics is best reduce social problem ?", "has_multiple_answer"=>"0", "answers_attributes"=>{"0"=>{"id"=>"", "answer"=>"A. yes", "_destroy"=>"false"}, "1"=>{"id"=>"", "answer"=>"B. no", "_destroy"=>"false"}}}
    poll =  Poll.create!(params[:poll])

    it "responds successfully for show method with an HTTP 200 status code" do
      get :show, {:id => poll.answers.first.id}
      expect(response).to be_success
      expect(response.status).to eq(200)
    end
  end

  describe "GET edit" do
    let(:user) { FactoryGirl.create(:user) }
    before { sign_in user }
    params = {}
    params[:poll] =  {"title"=>"Politics is best reduce social problem ?", "has_multiple_answer"=>"0", "answers_attributes"=>{"0"=>{"id"=>"", "answer"=>"A. yes", "_destroy"=>"false"}, "1"=>{"id"=>"", "answer"=>"B. no", "_destroy"=>"false"}}}
    poll =  Poll.create!(params[:poll])
    
    it "answer index action : assigns the requested answer as @answer" do
      answer = poll.answers.first
      get :edit, {:id => answer.to_param}
      assigns(:answer).should eq(answer)
    end
  end

  describe "PUT #update" do
    let(:user) { FactoryGirl.create(:user) }
    before { sign_in user }
    params = {}
    params[:poll] =  {"title"=>"Politics is best reduce social problem ?", "has_multiple_answer"=>"0", "answers_attributes"=>{"0"=>{"id"=>"", "answer"=>"A. yes", "_destroy"=>"false"}, "1"=>{"id"=>"", "answer"=>"B. no", "_destroy"=>"false"}}}
    poll =  Poll.create!(params[:poll])

    it "answer update action: update the requerted answer as @answer" do
      answer = poll.answers.first
      put :update, {:id => answer.id, :answer => {title: "A. yes"}}
      assigns(:answer).should eq(answer)
    end
    
    it "answer update action: update the requerted answer as @answer" do
      answer = poll.answers.first
      put :update, {:id => answer.id, :answer => {title: "A. yes"}}
      response.should redirect_to(answer)
    end
  end

  describe "DELETE#destroy" do
    let(:user) { FactoryGirl.create(:user) }
    before { sign_in user }

    params = {}
    params[:poll] =  {"title"=>"Politics is best reduce social problem ?", "has_multiple_answer"=>"0", "answers_attributes"=>{"0"=>{"id"=>"", "answer"=>"A. yes", "_destroy"=>"false"}, "1"=>{"id"=>"", "answer"=>"B. no", "_destroy"=>"false"}}}
    poll =  Poll.create!(params[:poll])
      
    it "destroys the requested answer" do
      expect {
        delete :destroy, {:id => poll.answers.first.id} 
      }.to change(Answer, :count).by(-1)
    end

    it "redirects to the answers list" do
      delete :destroy, {:id =>  poll.answers.first.id}
      response.should redirect_to(answers_url)
    end
  end
  
end

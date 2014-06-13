require "spec_helper"

describe PollsController do

  def valid_attributes
    {}
  end
  
  def valid_session
    {}
  end

  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
      get :index
      expect(response).to be_success
      expect(response.status).to eq(200)
    end
  end

  describe "GET #new" do
    it "a normal user can not open new poll page" do
      get :new
      expect(response).not_to be_success
      expect(response.status).to eq(302)
    end

    let(:user) { FactoryGirl.create(:member_user) }
    before { sign_in user }
  
    it "admin can open new poll page" do
      user.update_column(:role_id, 1)
      get :new
      assigns(:poll).should be_a_new(Poll)
    end
  end

  describe "POST #create with invalid params" do

    it "assigns a newly created but unsaved Poll as @poll" do
      user.update_column(:role_id, 1)
      # Trigger the behavior that occurs when invalid params are submitted
      Poll.any_instance.stub(:save).and_return(false)
      post :create, {:poll => {:title => "a testing poll."}}
      assigns(:poll).should be_a_new(Poll)
    end

    it "a normal user or unregisted user can not create poll." do
      # Trigger the behavior that occurs when invalid params are submitted
      post :create, {:poll => {:title => "a testing poll."}}
      expect(response).not_to be_success  
      expect(response.status).to eq(302)
    end
    
    let(:user) { FactoryGirl.create(:member_user) }
    before { sign_in user }
    
    it "re-renders the 'new' template" do
      user.update_column(:role_id, 1)
      # Trigger the behavior that occurs when invalid params are submitted
      Poll.any_instance.stub(:save).and_return(false)
      post :create, {:poll => {:title => ""}}
      response.should render_template("new")
    end

    it "admin create poll successfully without answers option" do
      user.update_column(:role_id, 1)
      params = {}
      params[:poll] =  {"title"=>"Politics is best reduce social problem ?", "has_multiple_answer"=>"0", "answers_attributes"=>{"0"=>{"id"=>"", "answer"=>"A. yes", "_destroy"=>"false"}, "1"=>{"id"=>"", "answer"=>"B. no", "_destroy"=>"false"}}}
      poll =  Poll.create!(params[:poll])
    
      expect(response).to be_success
      expect(response.status).to eq(200)
    end

    it "admin create poll successfully with answers option" do
      user.update_column(:role_id, 1)
      # Trigger the behavior that occurs when invalid params are submitted
      Poll.any_instance.stub(:save).and_return(false)
      post :create, {:poll => {:title => "a testing poll."}}
      expect(response).to be_success
      expect(response.status).to eq(200)
    end
    
  end
  
  describe "GET #edit" do
    it "a  normal user can open edit page" do
      poll =  Poll.create!(title: "a temporary title")
      get :edit, {:id => poll.to_param}
      expect(response).not_to be_success
      expect(response.status).to eq(302)
    end

    let(:user) { FactoryGirl.create(:member_user) }
    before { sign_in user }
    it "admin can open edit poll page" do
      user.update_column(:role_id, 1)
      poll =  Poll.create!(title: "a temporary title")
      get :edit, {:id => poll.to_param}
      response.should render_template("edit")
      expect(response.status).to eq(200)
    end
  end

  describe "PUT #update" do
    poll = Poll.create(:title => "a testing poll.")
    it "A admin can update to poll" do
      put :update, {:id => poll.to_param, :title => "a testing poll tiltle updated"}
      assigns(:poll).should_not eq(poll)
      expect(response).not_to be_success
      expect(response.status).to eq(302)
    end
  end

  describe "DELETE #destroy" do
    poll = Poll.create(:title => "a testing poll.")
    it "A normal user can not delete to poll" do
      expect {
        delete :destroy, {:id => poll.to_param}
      }.to change(Poll, :count).by(0)
      expect(response).not_to be_success
      expect(response.status).to eq(302)
    end
    poll = Poll.create(:title => "a testing poll.")
    let(:user) { FactoryGirl.create(:member_user) }
    before { sign_in user }

    it "A admin user can delete to poll" do
      user.update_column(:role_id, 1)
      expect {
        delete :destroy, {:id => poll.to_param}
      }.to change(Poll, :count).by(-1)
    end
    
  end

  describe "GET #show" do
    let(:user) { FactoryGirl.create(:user) }
    before { sign_in user }
    params = {}
    params[:poll] =  {"title"=>"Politics is best reduce social problem ?", "has_multiple_answer"=>"0", "answers_attributes"=>{"0"=>{"id"=>"", "answer"=>"A. yes", "_destroy"=>"false"}, "1"=>{"id"=>"", "answer"=>"B. no", "_destroy"=>"false"}}}
    poll =  Poll.create!(params[:poll])

    it "responds successfully for show method with an HTTP 200 status code" do
      get :show, {:id => poll.id}
      expect(response).to be_success
      expect(response.status).to eq(200)
    end
  end

  describe "GET #vote" do
    let(:user) { FactoryGirl.create(:user) }
    before { sign_in user }
    params = {}
    params[:poll] =  {"title"=>"Politics is best reduce social problem ?", "has_multiple_answer"=>"0", "answers_attributes"=>{"0"=>{"id"=>"", "answer"=>"A. yes", "_destroy"=>"false"}, "1"=>{"id"=>"", "answer"=>"B. no", "_destroy"=>"false"}}}
    poll =  Poll.create!(params[:poll])

    it "responds successfully for vote method with an HTTP 200 status code" do
      get :show, {:id => poll.id}
      expect(response).to be_success
      expect(response.status).to eq(200)
    end
  end

  describe "GET #response_to_poll" do
    let(:user) { FactoryGirl.create(:user) }
    before { sign_in user }
    params = {}
    params[:poll] =  {"title"=>"Politics is best reduce social problem ?", "has_multiple_answer"=>"0", "answers_attributes"=>{"0"=>{"id"=>"", "answer"=>"A. yes", "_destroy"=>"false"}, "1"=>{"id"=>"", "answer"=>"B. no", "_destroy"=>"false"}}}
    poll =  Poll.create!(params[:poll])

    it "responds successfully for response_to_poll method with an HTTP 200 status code" do
      post :response_to_poll, {:id => poll.id, "responses" => {answer_id: poll.answers.first.id}}
      expect(response).to be_success
      expect(response.status).to eq(200)
    end
  end

end

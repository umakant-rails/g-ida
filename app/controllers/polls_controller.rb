class PollsController < ApplicationController
  before_filter :authenticate_user!, except: [ :show, :vote, :response_to_poll]
  before_action :set_poll, only: [:show, :edit, :update, :destroy]
  
  # GET /polls
  # GET /polls.json
  def index
    @polls = []
    if current_user.role.name == 'Admin'
      @polls = Poll.all
    else
      @polls = current_user.polls
    end
  end

  # GET /polls/1
  # GET /polls/1.json
  def show
  end

  # GET /polls/new
  def new
    @poll = current_user.polls.new
    2.times do
      @poll.answers.build
    end
  end

  # GET /polls/1/edit
  def edit
    @poll = Poll.where("id = ? ", params[:id]).first
  end

  # POST /polls
  # POST /polls.json
  def create
    params[:poll][:answers_attributes].each{ |k ,v | v[:answer] = v[:answer].capitalize }  if params[:poll][:answers_attributes].present?
    params[:poll][:user_id] = current_user.id
    @poll = Poll.new(poll_params)
  
    respond_to do |format|
      if @poll.save
        format.html { redirect_to @poll, notice: 'Poll was successfully created.' }
        format.json { render action: 'show', status: :created, location: @poll }
      else
        2.times do
          @poll.answers.build
        end
        format.html { render action: 'new' }
        format.json { render json: @poll.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /polls/1
  # PATCH/PUT /polls/1.json
  def update
    respond_to do |format|
      if @poll.update(poll_params)
        format.html { redirect_to @poll, notice: 'Poll was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @poll.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /polls/1
  # DELETE /polls/1.json
  def destroy
    @poll.destroy
    respond_to do |format|
      format.html { redirect_to polls_url }
      format.json { head :no_content }
    end
  end

  def vote
    @poll = nil
    if current_user.blank?
      invitation = Invitation.where(:email => params[:email]).first
      invitation_polls =[]
      
      if invitation.present?
        invitation_polls = invitation.invitation_polls.where(:token => params[:tkn], :is_enabled => true)
      end
      if invitation_polls.present?
        @poll= Poll.find(params[:id])
      else
        redirect_to poll_path(params[:id])
      end
    else
      @poll= Poll.find(params[:id])
    end
  end

  def response_to_poll
    @poll = Poll.where("id = ?", params[:id].to_i).first
    invitation_poll = @poll.invitation_polls.where(:token => params[:responses][:token], :is_enabled => true).first

    if  invitation_poll.blank?
      flash[:info] = "you have voted for this question."
      redirect_to :back and return
    elsif invitation_poll.invitation && (invitation_poll.invitation.email == current_user.email)
      flash[:info] = "you can not vote for your question."
      redirect_to :back and return
    end

    begin
      responses_pameteres = responses_params
      if @poll.has_multiple_answer
        response_arr = []
        responses_pameteres[:answer_ids] && responses_pameteres[:answer_ids].each do |answer_id |
          response_arr << {answer_id: answer_id.to_i, poll_id: @poll.id} if answer_id.present?
        end
        if Response.create!(response_arr)
          invitation_poll.update_column(:is_enabled, false)
        end
      else
        if @poll.responses.create!(answer_id: responses_pameteres[:answer_id])
          invitation_poll.update_column(:is_enabled, false)
        end
      end
    rescue Exception => exp
      flash[:error] = exp.message
      redirect_to :back
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_poll
      @poll = Poll.find(params[:id])
    end

    def varify_admin
      if current_user.role_id != 1
        redirect_to polls_path
      end
    end
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def responses_params
      params.require(:responses)
    end
    
    def poll_params
      params.require(:poll).permit(:title, :info, :has_multiple_answer, :user_id , answers_attributes: [:id, :answer, :_destroy])
    end
end

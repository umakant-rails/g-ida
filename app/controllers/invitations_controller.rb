class InvitationsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @invitations = []
    if current_user.role.name == 'Admin'
      @invitations = Invitation.all
    else
      @invitations = current_user.invitations
    end
  end

  def new
    if current_user.role.name == 'Admin'
      @polls = Poll.all
    else
      @polls = current_user.polls
    end
  end

  def create
    begin
      Invitation.transaction do
        emails = params[:invite][:emails].split(",") if params[:invite][:emails]
        emails && emails.each do | email |
          invitation = Invitation.where(:email => email).first
          invitation = Invitation.create!(:email => email, :user_id => current_user.id) if invitation.blank?
          if params[:invite][:invited_for] == "all"
            all_polls = current_user.polls.map(&:id)
            invitation_poll_ids = invitation.invitation_polls.map(&:poll_id)
            polls_ids = all_polls - invitation_poll_ids
          else
            polls_ids = params[:invite][:polls].split(",").uniq
          end
          invitation_poll_arr = []
          polls_ids.each do |poll_id|
            token = SecureRandom.uuid
            if InvitationPoll.where(invitation_id: invitation.id, poll_id: poll_id.to_i).blank?
              invitation_poll_arr << { invitation_id: invitation.id, poll_id: poll_id.to_i,
                token: token, is_enabled: true}
            end
          end
          if invitation_poll_arr.present?
            ipolls = InvitationPoll.create!(invitation_poll_arr)
            InvitaionMailer.send_invitaoin_for_voting(invitation, ipolls).deliver
          end
        end
      end
      flash[:success] = "you successfully invited to #{params[:invite][:emails]}"
      redirect_to invitations_path
    rescue Exception => exp
      flash[:error] = "your invitation action is failed, please try again"
      redirect_to :back
    end
  end

  def invite_to_invited_peoples
    @polls = []
    @invitations = []
    if current_user.role.name == "Admin"
      @invitations = Invitation.all
    else
      @invitations = current_user.invitations
    end
  end

  def fetch_polls_to_invited_people
    if current_user.role.name == "Admin"
      assign_polls = Invitation.where("email = ? ", params[:email]).first.polls
      all_polls = Poll.all
      @polls_to_invited_peoples = (all_polls - assign_polls)
    else
      assign_polls = Invitation.where("email = ? ", params[:email]).first.polls.where("user_id = ? ", current_user.id)
      all_polls = current_user.polls
      @polls_to_invited_peoples = (all_polls - assign_polls)
    end
  end

  def invitations_polls
    invitation = Invitation.where("id = ? ", params[:id]).first
    @polls = invitation.polls
  end

end

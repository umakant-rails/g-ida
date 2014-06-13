class InvitaionMailer < ActionMailer::Base
  default from: "survey@gmail.com", content_type: "text/html"

  def send_invitaoin_for_voting(invitation, ipolls)
    @invitation = invitation
    @ipolls = ipolls
    mail(to: invitation.email, subject: 'Invitation for Polling')
  end
  
end

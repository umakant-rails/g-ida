class InvitationPoll < ActiveRecord::Base
  belongs_to :invitation
  belongs_to :poll

  validates :invitation_id, :presence => true
  validates :poll_id, :presence => true
  validates :token, :presence => true
end

class Invitation < ActiveRecord::Base

  has_many :invitation_polls
  has_many :polls, through: :invitation_polls
  belongs_to :user
  
  validates :email, :presence => true

end

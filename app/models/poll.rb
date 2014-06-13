class Poll < ActiveRecord::Base
	has_many :answers, :dependent => :destroy
  has_many :responses
  has_many :invitation_polls
  belongs_to :user
  accepts_nested_attributes_for :answers, reject_if: proc { |attributes| attributes['answer'].blank? },
    allow_destroy: true
  validates :title, :presence => true
  
end

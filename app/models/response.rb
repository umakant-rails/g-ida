class Response < ActiveRecord::Base
  belongs_to :answer
  belongs_to :poll

  belongs_to :user, foreign_key: :userid
  validates_presence_of :answer_id #, :userid
end

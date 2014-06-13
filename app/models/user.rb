class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  belongs_to :role
  has_many :polls
  has_many :invitations

  default_scope where(:mark_as_deleted => false)
    
  validates :email, presence: true, on: :create
  validates :role_id, presence: true, on: :create
  validates :first_name, presence: true, on: :create
  validates :last_name, presence: true, on: :create
  validates :password, length: {minimum: 8, maximum: 20}, presence: true, on: :create
  validates :password, length: {minimum: 8, maximum: 20}, on: :update, allow_blank: true

end

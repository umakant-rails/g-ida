class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  after_create :set_user_default_role
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  belongs_to :role
  has_many :polls
  has_many :invitations
  has_many :responses, class_name: "Response",
    foreign_key: "userid"

  #default_scope where(:mark_as_deleted => false)

  validates :email, presence: true, on: :create
  validates :username, presence: true, on: :create
  #~ validates :first_name, presence: true, on: :create
  #~ validates :last_name, presence: true, on: :create
  validates :password, length: {minimum: 8, maximum: 20}, presence: true, on: :create
  validates :password, length: {minimum: 8, maximum: 20}, on: :update, allow_blank: true

  private

  def set_user_default_role
    role = Role.where(name: "Client").first
    self.update_attribute(:role_id, role.id)
  end

end

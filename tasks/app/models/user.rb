class User < ActiveRecord::Base
#   Include default devise modules. Others available are:
#   :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable
  has_many :tasks, dependent: :destroy
  validates_presence_of :username
  validates_uniqueness_of :username
  validates_presence_of :password, on: :create
  validates_confirmation_of :password, on: :create
  validates_length_of :password, within: Devise.password_length, allow_blank: true

  def email_required?
    false
  end

  def email_changed?
    false
  end

  def avatar_path
    username+"/avatar.jpg"
  end
end

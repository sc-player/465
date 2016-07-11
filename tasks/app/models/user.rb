class User < ActiveRecord::Base
#   Include default devise modules. Others available are:
#   :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :tasks, dependent: :destroy

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

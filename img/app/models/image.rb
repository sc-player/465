class Image < ActiveRecord::Base
  belongs_to :user
  has_many :tags, dependent: :destroy
  has_many :users, through: :image_users
  has_many :image_users, dependent: :destroy
  def generate_filename
    self.filename=SecureRandom.uuid+".jpg"
  end
  def users_cant_see
    (User.all - [self.user] - self.users).map{|x| [x.name, x.id]}
  end
end

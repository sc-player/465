class Image < ActiveRecord::Base
  belongs_to :user
  has_many :tags, dependent: :destroy
  def generate_filename
    self.filename=SecureRandom.uuid+".jpg"
  end
end

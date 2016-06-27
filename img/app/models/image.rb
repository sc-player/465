class Image < ActiveRecord::Base
  belongs_to :user
  def generate_filename
    self.filename=SecureRandom.uuid+".jpg"
  end
end

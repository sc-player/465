class ImageUser < ActiveRecord::Base
  belongs_to :image
  belongs_to :user
  validates_presence_of :user_id
end

class Reference < ActiveRecord::Base
  before_validation :validURL
  validates :URL, presence: true
  validates :topic, presence: true
  validates :annotation, presence:true
  protected
    def validURL
      self.URL.prepend "http:\\" if self.URL =~ /^http[s]{1}:\/\//
    end
end



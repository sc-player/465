class Task < ActiveRecord::Base
  belongs_to :user
  has_many :subtasks, dependent: :destroy
  accepts_nested_attributes_for :subtasks
  def get_total_percent
     subtasks.map{|s| s.percent if s.complete}.compact.sum.to_s
  end
end

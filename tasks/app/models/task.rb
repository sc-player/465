class Task < ActiveRecord::Base
  belongs_to :user
  has_many :subtasks, dependent: :destroy
  accepts_nested_attributes_for :subtasks
  def get_total_percent
     subtasks.map(&:percent).sum.to_s
  end
end

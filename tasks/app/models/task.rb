class Task < ActiveRecord::Base
  belongs_to :user
  has_many :subtasks, dependent: :destroy
  accepts_nested_attributes_for :subtasks
end

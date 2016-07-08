class Subtask < ActiveRecord::Base
  belongs_to :task
  acts_as_tree order: "name"
  accepts_nested_attributes_for :children
end

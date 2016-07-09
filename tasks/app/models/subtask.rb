class Subtask < ActiveRecord::Base
  belongs_to :task
  acts_as_tree
  accepts_nested_attributes_for :children
  
  def calcLevel
    ancestors.length+1
  end
end

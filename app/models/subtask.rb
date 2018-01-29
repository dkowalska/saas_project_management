class Subtask < ApplicationRecord
  acts_as_tenant
  belongs_to :user
  belongs_to :task

  enum status: {defined: 0, in_progress: 1, completed: 2}
end

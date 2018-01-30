class Subtask < ApplicationRecord
  acts_as_tenant
  belongs_to :user
  belongs_to :task
  belongs_to :project

  enum status: {defined: 0, in_progress: 1, completed: 2}

  def humanize_status
    status.humanize
  end

  def self.status_options
    statuses.keys.map { |r| [r, r.humanize]}
  end

  def user_email
    user.email
  end
end

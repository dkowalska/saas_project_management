class Task < ApplicationRecord
  acts_as_tenant
  belongs_to :tenant
  belongs_to :project
  validates_presence_of :name
  validates_presence_of :status

  enum status: {defined: 0, in_progress: 1, completed: 2, account_acceptance: 3, client_acceptance: 4, published: 5}
  enum priority: {low: 0, medium: 1, high: 2}
end

class Comment < ApplicationRecord

  acts_as_tenant
  belongs_to :tenant
  belongs_to :user
  belongs_to :project
end

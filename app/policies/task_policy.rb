class TaskPolicy < ApplicationPolicy

  def can_create_tasks?
    user.admin? || user.account_manager?
  end
end
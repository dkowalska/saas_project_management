class ProjectPolicy < ApplicationPolicy

  def can_manage_projects?
    user.admin? || (user.projects.include?(record) && user.account_manager?)
  end
end
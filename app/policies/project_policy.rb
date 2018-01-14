class ProjectPolicy < ApplicationPolicy

  def can_manage_projects?
    user.admin? || (user.projects.include?(record) && user.account_manager?)
  end

  def can_create_projects?
    user.admin? || user.account_manager?
  end

  def can_manage_artifacts?
    user.tenants.first == record.tenant
  end
end
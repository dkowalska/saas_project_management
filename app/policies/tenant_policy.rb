class TenantPolicy < ApplicationPolicy
  def edit?
    user.admin?
  end
end
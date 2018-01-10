class UserPolicy < ApplicationPolicy
  def show?
    user.tenants.first.id == record.tenants.first.id
  end

  def edit?
    user == record
  end
end
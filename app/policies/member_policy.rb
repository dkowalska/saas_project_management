class MemberPolicy < ApplicationPolicy
  def new?
    user.admin?
  end
end
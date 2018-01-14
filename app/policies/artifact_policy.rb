class ArtifactPolicy < ApplicationPolicy
  def can_manage_artifacts?
    user.tenants.first == record.project.tenant
  end
end
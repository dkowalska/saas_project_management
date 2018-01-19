class Project < ApplicationRecord

  acts_as_tenant
  belongs_to :tenant
  validates_uniqueness_of :title
  has_many :comments, dependent: :destroy
  has_many :tasks, dependent: :destroy
  has_many :artifacts, dependent: :destroy
  has_many :user_projects, :dependent => :destroy
  has_many :users, through: :user_projects
  validate :free_plan_can_only_have_one_project

  def free_plan_can_only_have_one_project
    if self.new_record? && (tenant.projects.count > 0) && (tenant.plan == 'free')
      errors.add(:base, "Free plan account can only have one project")
    end
  end

  def self.by_user_plan_and_tenant(tenant_id, user)
    tenant = Tenant.find(tenant_id)
    if tenant.plan == 'premium'
      if user.is_admin? || user.is_account_manager?
        tenant.projects
      else
        user.projects.where(tenant_id: tenant.id)
      end
    else
      if user.is_admin? || user.is_account_manager?
        tenant.projects.order(:id).limit(1)
      else
        user.projects.where(tenant_id: tenant.id).order(:id).limit(1)
      end
    end
  end

  def self.current_projects(tenant_id, user)
    tenant = Tenant.find(tenant_id)
    if tenant.plan == 'premium'
      if user.is_admin? || user.is_account_manager?
        tenant.projects.where("expected_start_date < ? AND expected_completion_date > ?", Date.today, Date.today)
      else
        user.projects.where("tenant_id = ? AND expected_start_date < ? AND expected_completion_date > ?", tenant.id, Date.today, Date.today)
      end
    else
      if user.is_admin? || user.is_account_manager?
        tenant.projects.where("expected_start_date < ? AND expected_completion_date > ?", Date.today, Date.today).order(:id).limit(1)
      else
        user.projects.where("tenant_id = ? AND expected_start_date < ? AND expected_completion_date > ?", tenant.id, Date.today, Date.today).order(:id).limit(1)
      end
    end
  end


end

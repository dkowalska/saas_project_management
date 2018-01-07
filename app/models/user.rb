class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  acts_as_universal_and_determines_account
  has_one :member, :dependent => :destroy
  has_many :user_projects
  has_many :projects, through: :user_projects

  enum role: {admin: 0, account_manager: 1, graphic_designer: 2, copywriter: 3, client: 4}

  def is_admin?
    if role == 0
      true
    else
      false
    end
  end

  def is_account_manager?
    if role == 1
      true
    else
      false
    end
  end

  def is_employee?
    if ( role == 2 || role == 3 )
      true
    else
      false
    end
  end

  def is_client?
    if role == 4
      true
    else 
      false
    end
  end
end

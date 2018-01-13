class MembersController < ApplicationController

  # uncomment to ensure common layout for forms
  # layout  "sign", :only => [:new, :edit, :create]

  def new()
    authorize Member
    @member = Member.new()
    @user   = User.new()
  end

  def create()
    @user   = User.new( user_params )

    # ok to create user, member
    if @user.save_and_invite_member() && @user.create_member( member_params )
      flash[:notice] = "New member added and invitation email sent to #{@user.email}."
      redirect_to root_path
    else
      flash[:error] = "errors occurred!"
      @member = Member.new( member_params ) # only used if need to revisit form
      render :new
    end

  end

  def update()
    @member = Member.find(params[:id])
    if @member.update(member_params)
      flash[:notice] = 'Profile successfully updated'
      redirect_to root_url
    else
      flash[:error] = 'Error - profile cannot be updated'
      render template: 'devise/registrations/edit'
    end
  end


  private

  def member_params()
    params.require(:member).permit(:first_name, :last_name)
  end

  def user_params()
    params.require(:user).permit(:email, :password, :password_confirmation, :role)
  end

end

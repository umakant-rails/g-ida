class Users::RegistrationsController < Devise::RegistrationsController

  before_filter :update_sanitized_params, if: :devise_controller?
  
  def new
    @roles = Role.all
    super
  end

  def create
    @roles = Role.all
    super
  end

  def update
    
    if needs_password?(@user, user_params)
      if @user.update_with_password(user_params_password_update)
        flash[:success] = 'User was successfully updated. Password was successfully updated'
        redirect_to root_path
      else
        flash[:error] = @user.errors.full_messages.join(', ')
        redirect_to :back
      end
    else
      if @user.update_without_password(user_params)
        flash[:success] = 'User was successfully updated.'
        redirect_to profile_path(current_user)
      else
        flash[:error] = @user.errors.full_messages.join(', ')
        redirect_to :back
      end
    end
  end
  
  private
  
  def update_sanitized_params
    devise_parameter_sanitizer.for(:sign_up ) do |u|
      u.permit(:first_name, :last_name, :email, :role_id, :password, :password_confirmation )
    end
  end

  def needs_password?(user, user_params)
    !user_params[:password].blank?
  end


  def user_params
    params[:user].permit(:email, :password, :password_confirmation, :username, :first_name, :last_name)
  end
  
  #Need :current_password for password update
  def user_params_password_update
    params[:user].permit(:email, :password, :password_confirmation, :current_password, :username, :first_name, :last_name)
  end  

end

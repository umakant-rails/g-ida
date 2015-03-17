class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  layout :set_layout
  def after_sign_in_path_for(resource)
    if resource.role.present? && resource.role.name.eql?('Admin')
      responses_path
    else
      super
    end
  end

  def after_sign_in_path_for(resource)
    if resource.role.present? && resource.role.name.eql?('Admin')
      responses_path
    else
      super
    end
  end

  private
  def set_layout
    if current_user.present?
      role = current_user.role.name
      "#{role.downcase}_layout"
    else
      "application"
    end
  end
end

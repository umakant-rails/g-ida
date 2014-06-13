module ApplicationHelper
  def get_user_name_by_email(email)
    user_name = ''
    user_name = email.split('@')[0] if email.present?
    return user_name
  end
end

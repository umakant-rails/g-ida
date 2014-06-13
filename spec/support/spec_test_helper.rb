module SpecTestHelper   

  def sign_in(user)
    user = User.where(:email => user.email).first if user.is_a?(Symbol)
    request.session[:user] = user.id
  end

  def current_user
    User.find(request.session[:user])
  end
end

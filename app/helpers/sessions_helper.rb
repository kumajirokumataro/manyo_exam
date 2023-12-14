module SessionsHelper
  def current_user
    @test ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    current_user.present?
  end
end

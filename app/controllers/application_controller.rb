class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user, :signed_in_admin, :signed_in_employee,
    :signed_in_user, :mobile_device?, :withinDay

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def signed_in_admin
    if current_user.nil? || current_user.role != 'admin'
      redirect_to root_url, alert: "Only a signed in admin can perform that action"
    end
  end
  
  def signed_in_employee
    if current_user.nil?
      redirect_to events_path, alert: "Only an employee can take perform that action"
    elsif current_user.role == 'client'
      redirect_to events_path, alert: "Only an employee can take perfomr that action"
    end
  end
    
  def signed_in_user
    if current_user.nil?
      redirect_to log_in_path, alert: "Must be signed in to preform that action"
    end
  end

  def mobile_device?
    request.user_agent =~ /Mobile|webOS/
  end
  
  def withinDay(event)
    if event.date - Time.current < 24.hours
      true
    else
      false
    end
  end
end

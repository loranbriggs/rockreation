class UserMailer < ActionMailer::Base
  default from: "noreply@rockreation.com"

  def signup_confirmation(user)
    @user = user

    mail to: user.email, subject: "Welcome to the Rockreation Reservation System"
  end
  
  def alert_new_event(event)
    @event = event
    
    mail to: "info@codesquire.com", subject: "New event created"
  end
end

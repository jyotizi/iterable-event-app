class ApplicationController < ActionController::Base

  def after_sign_in_path_for(resource)
    return events_path(email: current_user.email)
  end
end

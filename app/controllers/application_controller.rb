class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :authorized?

  private
  
  def current_user
    warden.user
  end

  def warden
    env['warden']
  end

  def authorized?(record)
    unless record.user == current_user
      raise "Not Authorized"
    end
  end
end

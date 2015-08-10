class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.authenticate(params[:email], params[:password])
    if user && user.class.authenticate(params['email'], params[:password])
      session[:user_id] = user.id
      redirect_to root_url, notice: 'Logged in'
    else
      flash.now[:alert] = 'Login failed'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: 'Logged out'
  end
end

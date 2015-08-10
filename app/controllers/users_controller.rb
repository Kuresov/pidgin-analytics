class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(params.require(:user).permit(:email, :password))

    if @user.save
      warden.set_user(@user)
      redirect_to root_url, notice: 'Account created'
    else
      render :new
    end
  end
end

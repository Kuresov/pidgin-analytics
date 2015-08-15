class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      warden.set_user(@user)
      UserMailer.registration_confirmation(@user).deliver_now
      redirect_to root_url, notice: 'Account created'
    else
      render :new
    end
  end

  def edit
    @user = User.find(current_user)
  end

    def update
      @user = User.find(current_user)

      if @user.update_attributes(user_params)
        redirect_to account_path, notice: "#{@user.email} preferences saved!"
      else
        flash.now[:error] = "There was a problem saving your preferences."
        render :edit
      end
    end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :current_password)
  end
end

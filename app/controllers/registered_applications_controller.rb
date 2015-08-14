class RegisteredApplicationsController < ApplicationController

  def index
    @applications = RegisteredApplication.all
  end

  def new
    @application = RegisteredApplication.new
  end

    def create
      @application = current_user.registered_applications.build(registered_application_params)

      if @application.save
        flash[:notice] = "#{@application.name} created"
        redirect_to @application
      else
        flash.now[:error] = "Your application could not be created. Please try again."
        render :new
      end
    end

  def show
    @application = RegisteredApplication.find(params[:id])
    @events = @application.events.group_by(&:name)
  end

  def edit
    @application = RegisteredApplication.find(params[:id])
  end

    def update
      @application = RegisteredApplication.find(params[:id])

      if @application.update_attributes(registered_application_params)
        flash[:notice] = "#{@application.name} updated"
        redirect_to action: 'index'
      else
        flash.now[:error] = "The application could not be updated. Please try again."
        render :edit
      end
    end


  def destroy
    @application = RegisteredApplication.find(params[:id])

    if @application.destroy
      flash[:notice] = "Application '#{@application.name}' deleted"
      redirect_to action: 'index'
    else
      flash.now[:error] = "The application could not be deleted. Please try again"
      render :show
    end
  end

  private

    def registered_application_params
      params.require(:registered_application).permit(:name, :url)
    end
end

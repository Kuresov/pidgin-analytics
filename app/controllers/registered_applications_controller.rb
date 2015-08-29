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
    @event_count = @application.events.count

    @events_by_name = Event.where(registered_application_id: params[:id]).order(:name).group_by { |event| event.name }

    #Get events associated with application from params
    #---group by name
    #------group by date

    #@sql = Event.where(registered_application_id: params[:id]).group_by { |event| [event.name, event.created_at.to_date] }
    #@sql = Event.where(registered_application_id: params[:id]).group(:name).group_by { |event| event.created_at.to_date }

    @sql = Event.where(registered_application_id: params[:id])
                .group("date(created_at)")
                .group(:name).count

    #SELECT name, COUNT(id), created_at FROM events WHERE registered_application_id = 13 GROUP BY name, created_at;

    # Get last 7 days for charting
    @days = []
    0.upto(6) { |i| @days << [Date.today - i] }
    
    @data2 = []
   
    @days.each do |day|
      @sql.each do |item|
        if item[0][0]== day
          @data2 << item[1]
        else
          @data2 << [item[0][0]]
        end
      end
    end

    @data = {}
    @events_by_name.each do |name, events|
      @data[name] = {}

      @days.each do |day|
        @data[name][day] = 0

        events.each do |event|
          if event.created_at.to_date == day
            @data[name][day] += 1
          end
        end
      end
    end
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

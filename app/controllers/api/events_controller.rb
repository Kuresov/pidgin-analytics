class API::EventsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :cors_preflight_check
  after_action :cors_set_access_control_headers

  def cors_preflight_check
    if request.method == 'OPTIONS'
      headers['Access-Control-Allow-Origin'] = '*'
      headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
      headers['Access-Control-Allow-Headers'] = 'content-type'

      render json: '', content_type: 'text-plain'
    end
  end

  def cors_set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
    headers['Access-Control-Allow-Headers'] = 'content-type'
  end

  def create
    application = RegisteredApplication.find_by(url: request.env['HTTP_ORIGIN'])

    if application.nil?
      render json: "Unregistered application", status: :unprocessable_entity
    else
      @event = application.events.build(event_params)

      if @event.save!
        render json: @event, status: :created
      else
        render @event.errors, status: :unprocessable_entity
      end
    end
  end

  private

  def event_params
    params.permit(:name)
  end
end

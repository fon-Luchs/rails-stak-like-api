class ApplicationController < ActionController::Base
  attr_reader :current_user

  helper_method :collection, :resource,
                :current_user, :resource_param,
                :resource_response

  before_action :authenticate!

  skip_before_action :verify_authenticity_token, if: -> { request.format.json? }

  def create
    render :errors unless resource.save
    resource_response if resource.save
  end

  def destroy
    @message = '204 No Content'
    resource.destroy
    render json: message, status: 204
  end

  def update
    render :errors unless resource.update(resource_params)
    resource_response if resource.save
  end

  rescue_from ActionController::ParameterMissing do |exception|
    @exception = exception

    render :exception, status: :unprocessable_entity
  end

  rescue_from ActiveRecord::RecordNotFound do
    @exception = 'Not Found'

    render :exception, status: :not_found
  end

  rescue_from ActiveRecord::RecordInvalid, ActiveModel::StrictValidationFailed do
    render :errors, status: :unprocessable_entity
  end

  private

  def authenticate!
    authenticate_or_request_with_http_token do |token, options|
      @current_user = User.joins(:auth_token).find_by auth_tokens: { value: token }
    end
  end
end

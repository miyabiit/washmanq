class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  add_flash_types :from, :to

  rescue_from ActionController::RoutingError, with: :handle_not_found_exception
  rescue_from ActiveRecord::RecordNotFound,   with: :handle_not_found_exception

  unless Rails.env.development? || Rails.env.test?
    before_action :basic_auth
    def basic_auth
      authenticate_or_request_with_http_basic do |user, pass|
        (user == ENV["BASIC_AUTH_USER"] && pass == ENV["BASIC_AUTH_PASSWORD"]) || (user == ENV["BASIC_AUTH_USER1"] && pass == ENV["BASIC_AUTH_PASSWORD1"]) || (user == ENV["BASIC_AUTH_USER2"] && pass == ENV["BASIC_AUTH_PASSWORD2"])
      end
    end
  end

  private
    def handle_not_found_exception(ex)
      @exception = ex
      @status = :not_found
      logger.debug "#{ex.class.name} - #{ex.message}" if ex
      if ex.cause
        logger.debug "cause = #{ex.cause.message}"
        logger.debug " -#{ex.cause.backtrace.join("  \n")}"
      end
      @message = t('errors.messages.not_found')
      respond_to do |format|
        format.json { render json: {errors: [{message: @message}]}, status: @status }
        format.html { render 'errors/error', status: @status}
      end
    end
end

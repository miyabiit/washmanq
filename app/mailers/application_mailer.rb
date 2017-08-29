class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'mailer'

  rescue_from Exception, with: :handle_error

  private

  def handle_error(exception = nil)
    logger.error "System Error!"
    if exception
      logger.error exception.message
      logger.error exception.backtrace.join("\n  ")
    end
  end
end

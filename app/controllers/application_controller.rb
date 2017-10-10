class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  add_flash_types :from, :to

  unless Rails.env.development? || Rails.env.test?
    before_action :basic_auth
    def basic_auth
      authenticate_or_request_with_http_basic do |user, pass|
        (user == ENV["BASIC_AUTH_USER"] && pass == ENV["BASIC_AUTH_PASSWORD"]) || (user == ENV["BASIC_AUTH_USER1"] && pass == ENV["BASIC_AUTH_PASSWORD1"]) || (user == ENV["BASIC_AUTH_USER2"] && pass == ENV["BASIC_AUTH_PASSWORD2"])
      end
    end
  end
end

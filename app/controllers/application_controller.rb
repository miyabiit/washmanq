class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  unless Rails.env.development? || Rails.env.test?
    http_basic_authenticate_with name: ENV['BASIC_AUTH_USER'], password: ENV['BASIC_AUTH_PASSWORD']
  end
end

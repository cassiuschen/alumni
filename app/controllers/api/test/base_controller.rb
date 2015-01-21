class Api::Test::BaseController < ActionController::Base
  #before_action :check_env

  private
  def check_env
    unless Rails.env.development?
      raise ForbiddenError
    end
  end
end
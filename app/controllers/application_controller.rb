class ApplicationController < ActionController::Base
  private

  def current_user
    @current_user ||= User.first
  end
end

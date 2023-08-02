class RegistrationsController < ApplicationController
  private

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name)
  end

  def update_resource(resource, params)
    if params[:password].blank? && params[:password_confirmation].blank?
      resource.update_without_password(params.except(:password, :password_confirmation))
    else
      resource.update_with_password(params)
    end
  end

  def account_update_params
    params.require(:user).permit(:email, :password, :password_confirmation, :current_password)
  end
end

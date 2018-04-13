class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  include DeviseTokenAuth::Concerns::SetUserByToken
  include ApplicationHelper

  def home
  end

  def resource_params
    params.permit(devise_parameter_sanitizer.for(:sign_in))
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email,:password,:password_confirmation,:name,:cpf,:birthday,:gender])
  end

end

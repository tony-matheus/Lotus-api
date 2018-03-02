class ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken
  include ApplicationHelper

  def home
  end

  def resource_params
    params.permit(devise_parameter_sanitizer.for(:sign_in))
  end

end

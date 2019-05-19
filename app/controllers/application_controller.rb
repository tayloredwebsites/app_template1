class ApplicationController < ActionController::Base
  include ApplicationHelper

  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [
        :given_name,
        :family_name,
        :role,
        :deleted
      ])
      devise_parameter_sanitizer.permit(:account_update, keys: [
        :given_name,
        :family_name,
        :role,
        :deleted
      ])
    end

  end
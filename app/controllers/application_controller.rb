class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: 'Su usuario no esta autorizado para realizar esta accion'
  end

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) << [:name, :lastname, :username]
      devise_parameter_sanitizer.for(:account_update) << [:name, :lastname, :username]
  end


  #def check_admin!
    #  authenticate_user!

    #  unless current_user.admin?
    #    redirect_to root_path, alert: 'Este usuario no esta habilitado para realizar esa accion'
    #  end
    #end
    #def check_editor!
    #  authenticate_user!

    #  unless current_user.editor?
    #    redirect_to root_path, alert: 'Este usuario no esta habilitado para realizar esa accion'
    #  end
    #end
end

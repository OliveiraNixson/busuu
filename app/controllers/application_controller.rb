class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :authorize

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  helper_method :current_user

  def current_permission
    @current_permission ||= Permission.new(current_user)
  end

  helper_method :current_permission
end

  def authorize
    if current_permission.allow?(params[:controller], params[:action])
      respond_to do |format|
        format.html { redirect_to root_path, alert: "You are not authorized to access" }
        format.turbo_stream do
          flash.now[:alert] = "You are not authorized to access"
          render turbo_stream: [ turbo_stream.append("flash", partial: "layouts/flash") ]
        end
    end
    end
end

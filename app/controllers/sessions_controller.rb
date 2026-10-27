class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.authenticate(params[:user][:email], params[:user][:password])
    puts params
    respond_to do |format|
      if user
        session[:user_id] = user.id
        format.html { redirect_to pages_path, notice: "Logged in!" }
        format.json
      else
        flash[:alert] = "Email or login incorrect"
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: { error: "Email or login incorrect" }, status: :unprocessable_entity }
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.append("flash", partial: "layouts/flash"),
            turbo_stream.replace("session-form", partial: "sessions/form")
          ]
        end
      end
    end
  end

  def logout
    session[:user_id] = nil
    respond_to do |format|
      format.html { redirect_to root_path, notice: "Logged out!" }
      format.json
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.append("flash", partial: "layouts/flash", locals: { notice: "Logged out!" })
        ]
      end
    end
  end
end

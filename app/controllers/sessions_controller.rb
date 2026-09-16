class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.authenticate(params[:email], params[:password])

    respond_to do |format|
      if user.present?
        session[:user_id] = user.id
        format.html{ redirect_to pages_path, notice: "Logged in!" }
        format.turbo_stream{ redirect_to pages_path, notice: "Logged in!" }
      else
        format.html{ render :new, status: :unprocessable_entity }
        format.turbo_stream do 
          flash.now[:alert] = "Invalid email or password!"
          render turbo_stream: [
            turbo_stream.append("flash", partial:"layouts/flash"),
            turbo_stream.update("form", "")
          ]
        end
      end
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Logged out!"
  end
end

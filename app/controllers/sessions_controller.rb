class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.authenticate(params[:user][:email], params[:user][:password])
    puts params
    respond_to do |format|
      if user
        session[:user_id] = user.id
        format.html{ redirect_to pages_path, notice: "Logged in!" }
        format.json
      else
        flash[:alert] = "Email or login incorrect"
        format.html{ render :new, status: :unprocessable_entity }
      end
    end
  end
end

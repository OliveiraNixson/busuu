class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to pages_path, notice: "Thanks, for your signing up!" }
        format.turbo_stream { redirect_to pages_path, notice: "Thanks, for your signing up!" }
      else
        flash.now[:alert] = "Invalid parameters."
        format.html { render :new, status: :unprocessable_entity }
        format.turbo_stream do
          render turbo_stream: turbo_stream.append("flash", partial: "layouts/flash")
        end
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :name,
      :email,
      :password,
      :password_confirmation,
      :current_language_id
    )
  end
end

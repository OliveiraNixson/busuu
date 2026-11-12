class UsersController < ApplicationController
  before_action :set_user, only: [ :update, :destroy, :update_language ]

  # GET /users
  def index
    @users = User.all

    # Omite campos sensíveis do retorno JSON
    render json: @users.as_json(except: [ :password_hash, :password_salt ])
  end

  def new
    @user = User.new
  end

  # POST /users
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to pages_path, notice: "Wellcome #{@user.name}" }
        format.json { render json: @user.as_json(except: [ :password_hash, :password_salt ]), status: :created }
        format.turbo_stream do
          flash.now[:notice] = "Wellcome #{@user.name}"
          render turbo_stream: turbo_stream.append("flash", partial: "layouts/flash")
        end
      else
        format.html { render :new }
        format.json { render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity }
        format.turbo_stream do
          flash.now[:alert] = @user.errors.full_messages.join(", ")
          render turbo_stream: turbo_stream.append("flash", partial: "layouts/flash")
        end
      end
    end
  end

  # PATCH/PUT /users/:id
  def update
    if @user.update(user_update_params)
      render json: @user.as_json(except: [ :password_hash, :password_salt ])
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /users/:id
  def destroy
    @user.destroy
    head :no_content
  end

  def languages
    @learning_languages = current_user.languages
    @not_learning_languages = Language.all - @learning_languages
  end

  def update_language
    language = Language.find(params[:language_id])
    current_user.languages << language
    current_user.current_language = language
    if current_user.save
      flash[:notice] = "Learning now #{language.name}!"
      respond_to do |format|
        format.html { redirect_to language_courses_path(language), notice: "Learning now #{language.name}!" }
        format.turbo_stream do
          flash.now[:notice] = "Learning now #{language.name}!"
          render turbo_stream:[ 
            turbo_stream.update("modalcontainer", ""),
            turbo_stream.replace("header", partial: "layouts/header"),
            turbo_stream.append("flash", partial: "layouts/flash") ]
        end
      end    
    else
      flash[:alert] = "Errors: #{current_user.errors.full_messages.join(", ")}"
      respond_to do |format|
        format.html { redirect_to pages_path, alert: "Errors: #{current_user.errors.full_messages.join(", ")}" }
      end
    end
  end

  private

  def set_user
    @user = User.find(params[:id] || params[:user_id])
  end

  # Strong Parameters para criação
  def user_params
    params.require(:user).permit(:name, :email, :current_language_id, :password)
  end

  # Strong Parameters para atualização (evita alteração indevida de dados sensíveis)
  def user_update_params
    params.require(:user).permit(:name, :current_language_id, :password, :password_confirmation)
  end
end

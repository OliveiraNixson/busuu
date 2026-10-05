class UsersController < ApplicationController
  before_action :set_user, only: [ :update, :destroy]

  # GET /users
  def index
    @users = User.all
    
    # Omite campos sensíveis do retorno JSON
    render json: @users.as_json(except: [:password_hash, :password_salt])
  end

  def new
    @user = User.new
  end

  # POST /users
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html{ redirect_to pages_path, notice: "Wellcome #{@user.name}" }
        format.json{ render json: @user.as_json(except: [:password_hash, :password_salt]), status: :created }
      else
        format.html{ render :new }
        format.json{ render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/:id
  def update
    if @user.update(user_update_params)
      render json: @user.as_json(except: [:password_hash, :password_salt])
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /users/:id
  def destroy
    @user.destroy
    head :no_content
  end

  private

  def set_user
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Usuário não encontrado' }, status: :not_found
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
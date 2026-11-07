class LanguagesController < ApplicationController
  before_action :set_language, only: [ :edit, :update ]

  def index
    @languages = Language.all
    @key = params[:key]
  end

  def new
    @language = Language.new
  end

  def create
    @language = Language.new(language_params)
    respond_to do |format|
      if @language.save
        format.html { redirect_to languages_path, notice: "Language created successfully." }
        format.json { render json: @language, status: :created }
        format.turbo_stream do
          flash.now[:notice] = "Language created successfully."
          render turbo_stream: [
            turbo_stream.update("remote-modal", ""),
            turbo_stream.append("flash", partial: "layouts/flash")
          ]
        end
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: { errors: @language.errors.full_messages }, status: :unprocessable_entity }
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace("language_form", partial: "form", locals: { language: @language }), status: :unprocessable_entity
        end
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @language.update(language_params)
        format.html { redirect_to languages_path, notice: "Language updated successfully." }
        format.json { render json: @language, status: :ok }
        format.turbo_stream do
          flash.now[:notice] = "Language updated successfully."
          render turbo_stream: [
            turbo_stream.update("remote-modal", ""),
            turbo_stream.append("flash", partial: "layouts/flash")
          ]
        end
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: { errors: @language.errors.full_messages }, status: :unprocessable_entity }
        format.turbo_stream do
          flash.now[:alert] = @language.errors.full_messages.join(", ")
          render turbo_stream: turbo_stream.append("flash", partial: "layouts/flash"), status: :unprocessable_entity
        end
      end
    end
  end

  private

  def language_params
    params.require(:language).permit(:name, :flag)
  end

  def set_language
    @language = Language.find(params[:id])
  end
end

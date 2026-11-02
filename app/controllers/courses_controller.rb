class CoursesController < ApplicationController
  before_action :set_language, only: [ :edit, :update ]
  before_action :set_course, only: [ :show, :update ]

  def index
    @courses = Course.includes(:language).order(:name)
  end

  def edit
    @course = @language.courses.find(params[:id])
  end

  def new
    @course = Course.new
  end

  def create
    @course = Course.new(course_params)

    respond_to do |format|
      if @course.save
        format.html { redirect_to courses_path, notice: "Course was successfully created." }
        format.json { render json: @course, status: :created, location: @course }
        format.turbo_stream do
          flash.now[:notice] = "Course was successfully created."
          render turbo_stream: [
            turbo_stream.update("remote-modal", ""),
            turbo_stream.append("flash", partial: "layouts/flash")
          ]
        end
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: { errors: @course.errors.full_messages }, status: :unprocessable_entity }
        format.turbo_stream do
          flash.now[:alert] = @course.errors.full_messages.join(", ")
          render turbo_stream: turbo_stream.append("flash", partial: "layouts/flash"), status: :unprocessable_entity
        end
      end
    end
  end

  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to @course, notice: "Course was successfully updated." }
        format.json { render json: @course, status: :ok, location: @course }
        format.turbo_stream do
          flash.now[:notice] = "Course was successfully updated."
          render turbo_stream: [
                      turbo_stream.update("remote-modal", ""),
                      turbo_stream.append("flash", partial: "layouts/flash")
                    ]
        end
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: { errors: @course.errors.full_messages }, status: :unprocessable_entity }
        format.turbo_stream do
          flash.now[:alert] = @course.errors.full_messages.join(", ")
          render turbo_stream: turbo_stream.append("flash", partial: "layouts/flash"), status: :unprocessable_entity
        end
      end
    end
  end

  def show
  end

  private

  def set_language
    @language = Language.find(params[:language_id])
  end

  def set_course
    @course = Course.find(params[:id])
  end

  def course_params
    params.require(:course).permit(:name, :language_id, :description, level_ids: [])
  end
end

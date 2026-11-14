class CoursesController < ApplicationController
  before_action :set_language
  before_action :set_course, only: [ :edit, :show, :update ]

  def index
    current_user.update(current_language: @language)
    @courses = @language.courses.order(:name)
  end

  def edit
    @course = @language.courses.find(params[:id])
  end

  def new
    @course = @language.courses.build
  end

  def create
    @course = @language.courses.build(course_params)

    respond_to do |format|
      if @course.save
        format.html { redirect_to language_courses_path(@language), notice: "Course was successfully created." }
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
        format.html { redirect_to language_courses_path(@language), notice: "Course was successfully updated." }
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
    @language = Language.find(params[:language_id] || params.dig(:course, :language_id))
  end

  def set_course
    @course = Course.find(params[:id])
  end

  def course_params
    params.require(:course).permit(:name, :language_id, :description, level_ids: [])
  end
end

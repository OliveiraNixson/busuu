class SectionsController < ApplicationController
    before_action :set_course, only: [ :index ]
    before_action :set_section, only: [ :edit, :update ]

    def index
        @sections = @course.sections
    end

    def new
        @section = Section.new
    end

    def create
        @section = Section.new(section_params)

        respond_to do |format|
            if @section.save
                format.html { redirect_after_save }
                format.turbo_stream { render_saved_turbo_stream }
            else
                format.html { render :new, status: :unprocessable_entity }
                format.turbo_stream { render_invalid_turbo_stream }
            end
        end
    end

    def edit
    end

    def update
        respond_to do |format|
            if @section.update(section_params)
                format.html { redirect_after_save }
                format.turbo_stream { render_saved_turbo_stream }
            else
                format.html { render :edit, status: :unprocessable_entity }
                format.turbo_stream { render_invalid_turbo_stream }
            end
        end
    end

    def languages
        @languages = Language.all 
    end

    private

    def set_course
        @course = Course.find(params[:course_id])
    end

    def set_section
        @section = Section.find(params[:id])
    end

    def section_params
        params.require(:section).permit(:name, :level_id, :course_id)
    end

    def redirect_after_save
        if @section.course
            redirect_to timeline_course_path(@section.course), notice: "Section was successfully saved."
        else
            redirect_to edit_section_path(@section), notice: "Section was successfully saved."
        end
    end

    def render_saved_turbo_stream
        flash.now[:notice] = "Section was successfully saved."
        render turbo_stream: [
            turbo_stream.update("remote-modal", ""),
            turbo_stream.update("flash", partial: "layouts/flash")
        ]
    end

    def render_invalid_turbo_stream
        flash.now[:alert] = @section.errors.full_messages.to_sentence
        render turbo_stream: [
            turbo_stream.replace("section_form", partial: "sections/form", locals: { section: @section }),
            turbo_stream.update("flash", partial: "layouts/flash")
        ], status: :unprocessable_entity
    end
end

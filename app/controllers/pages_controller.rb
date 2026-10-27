class PagesController < ApplicationController
  def index
    @course_count = Course.count
    @level_count = Level.count
    @lesson_count = Lesson.count
    @levels = Level.order(:order).limit(6)
    @level_course_counts = LevelCourse.group(:level_id).count
    @courses = Course.includes(:language).order(:name).limit(4)
    @lesson_counts = Lesson.group(:course_id).count
  end
end

class CourseDecorator < Draper::Decorator
  delegate_all

  def levels_range
    "#{levels&.order(:order)&.first&.code} - #{levels&.order(:order)&.last&.code}"
  end
end

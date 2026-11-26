class Section < ApplicationRecord
  belongs_to :level
  belongs_to :course, optional: true
  has_many :lessons

  def completed_lessons_count
    lessons.count { |lesson| lesson.done? }
  end

  def progress_percentage
    total_lessons = lessons.size
    return 0 if total_lessons.zero?

    (completed_lessons_count.to_f / total_lessons * 100).round
  end
end

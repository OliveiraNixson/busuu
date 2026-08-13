class LevelCourse < ApplicationRecord
  belongs_to :course
  belongs_to :level
end

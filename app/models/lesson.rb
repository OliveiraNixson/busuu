class Lesson < ApplicationRecord
  belongs_to :section
  belongs_to :course
  belongs_to :language
end

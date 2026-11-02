class Course < ApplicationRecord
  belongs_to :language
  has_many :level_courses
  has_many :levels, through: :level_courses

  validates :name, presence: true
  validates :description, presence: true
end

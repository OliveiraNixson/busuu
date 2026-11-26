class Course < ApplicationRecord
  belongs_to :language
  belongs_to :current_level, class_name: 'Level', foreign_key: 'current_level_id'
  has_many :level_courses
  has_many :levels, through: :level_courses
  has_many :lessons

  validates :name, presence: true
  validates :description, presence: true
end

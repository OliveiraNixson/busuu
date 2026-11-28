class Level < ApplicationRecord
    has_many :level_courses
    has_many :courses, through: :level_courses
        has_many :sections
        has_many :current_courses, class_name: "Course", foreign_key: "current_level_id"



    validates :name, presence: true
    validates :code, presence: true
end

class Level < ApplicationRecord
    has_many :level_courses
    has_many :courses, through: :level_coursess
    validates :name, presence: true
    validates :code, presence: true
end

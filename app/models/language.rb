class Language < ApplicationRecord
    has_many :courses, dependent: :destroy

    validates :flag, presence: true
    validates :name, presence: true
end

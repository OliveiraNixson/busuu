class Language < ApplicationRecord
    has_many :courses, dependent: :destroy
    has_many :users, dependent: :destroy, foreign_key: "current_language_id"

    validates :flag, presence: true
    validates :name, presence: true
end

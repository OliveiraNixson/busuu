class User < ApplicationRecord
  belongs_to :current_language, class_name: "language"
end

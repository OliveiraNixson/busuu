class LevelDecorator < Draper::Decorator
  delegate_all

  def description
    "#{object.name} - #{object.code}"
  end
end

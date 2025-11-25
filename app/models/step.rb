class Step < ApplicationRecord
  # Associations
  belongs_to :recipe

  # Validations
  validates :step_number, presence: true,
                          numericality: { greater_than: 0, only_integer: true },
                          uniqueness: { scope: :recipe_id, message: "ce numéro d'étape existe déjà" }
  validates :instruction, presence: true, length: { minimum: 10 }
  validates :duration_minutes, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true

  # Scopes
  scope :ordered, -> { order(step_number: :asc) }

  # Méthode pour formater la durée
  def formatted_duration
    return nil unless duration_minutes

    if duration_minutes >= 60
      hours = duration_minutes / 60
      mins = duration_minutes % 60
      mins.zero? ? "#{hours}h" : "#{hours}h#{mins}min"
    else
      "#{duration_minutes} min"
    end
  end
end

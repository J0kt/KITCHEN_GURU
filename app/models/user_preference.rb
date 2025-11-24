class UserPreference < ApplicationRecord
  # La version actuelle de Rails exige que le coder soit spécifié pour la sérialisation d'un Array dans un champ TEXT.
  require 'json'
  serialize :allergies, Array, coder: JSON
  # -----------------------------------------------------------

  # Validation de base pour s'assurer que les données essentielles sont présentes
  validates :age, presence: true, numericality: { greater_than_or_equal_to: 18 }
  validates :gender, presence: true, inclusion: { in: %w[homme femme autre] }
  validates :activity_level, presence: true, inclusion: { in: %w[sédentaire modéré actif] }
  validates :weekly_budget_max, presence: true, numericality: { greater_than: 0 }
  validates :max_prep_time_minutes, presence: true, numericality: { greater_than_or_equal_to: 5 }

  # Méthode pour calculer les besoins énergétiques totaux ajustés (base ZOE)
  # Ce calcul est la base du besoin calorique fourni à l'IA.
  def calculate_recommended_kcal
    # 1. Calcul du Métabolisme de Base (MB) simplifié
    base_kcal = case gender
                when 'homme' then 1700
                when 'femme' then 1500
                else 1600
                end

    # 2. Ajustement selon le niveau d'activité (Facteur d'Activité Physique)
    activity_factor = case activity_level
                      when 'sédentaire' then 1.2
                      when 'modéré' then 1.55
                      when 'actif' then 1.9
                      else 1.4
                      end

    (base_kcal * activity_factor).round
  end
end

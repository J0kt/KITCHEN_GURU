class UserPreference < ApplicationRecord
  require 'json'
  serialize :allergies, type: Array, coder: JSON

  validates :age, presence: true, numericality: { greater_than_or_equal_to: 18 }
  validates :gender, presence: true, inclusion: { in: %w[homme femme autre] }
  validates :activity_level, presence: true, inclusion: { in: %w[sédentaire modéré actif] }
  validates :weekly_budget_max, presence: true, numericality: { greater_than: 0 }
  validates :max_prep_time_minutes, presence: true, numericality: { greater_than_or_equal_to: 5 }

  def calculate_recommended_kcal
    base_kcal = case gender
                when 'homme' then 1700
                when 'femme' then 1500
                else 1600
                end

    activity_factor = case activity_level
                      when 'sédentaire' then 1.2
                      when 'modéré' then 1.55
                      when 'actif' then 1.9
                      else 1.4
                      end

    (base_kcal * activity_factor).round
  end
end

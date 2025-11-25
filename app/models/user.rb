class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :profile, dependent: :destroy
  has_many :recipes, dependent: :destroy

  after_create :create_profile

  private

  def create_profile
    Profile.create!(
      user: self,
      gender: 'Other',
      age: 18,
      activity_level: 'Sedentary',
      weekly_budget_max: 0.0,         # Placeholder
      max_prep_time_minutes: 60,      # Placeholder
      allergies: ''                   # Placeholder
    )
  end
end

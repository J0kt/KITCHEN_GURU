class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :profile, dependent: :destroy
  has_many :recipes, dependent: :destroy
  has_many :meal_plans, dependent: :destroy

  after_create :create_profile

  private

  def create_profile
    Profile.create!(
      user: self,
      gender: 'Other',
      age: 18,
      activity_level: 'Sedentary',
      weekly_budget_max: 0.0,
      max_prep_time_minutes: 60,
      allergies: ''
    )
  end
end

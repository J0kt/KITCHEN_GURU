class PagesController < ApplicationController
  def home
    # Initialise un objet UserPreference pour remplir le formulaire.
    # Les valeurs par défaut sont importantes pour que la vue s'affiche sans erreur.
    @user_preference = UserPreference.new(
      age: 30,
      gender: 'femme',
      activity_level: 'modéré',
      weekly_budget_max: 80,
      max_prep_time_minutes: 30,
      allergies: ['Gluten']
    )
    # Assurez-vous que @meal_plan est nil, car aucun plan n'est généré sur la page d'accueil
    @meal_plan = nil
  end
end

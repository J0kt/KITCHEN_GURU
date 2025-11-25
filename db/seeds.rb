puts "Seeding the database..."

# 1. Crée un Utilisateur de base (si n'existe pas)
# Note: Devise gère l'encryptage du mot de passe lors de la création
user = User.find_or_create_by!(email: 'jo_sample@example.com') do |u|
  puts "Creating initial User: jo_sample@example.com"
  u.password = 'password123'
  u.password_confirmation = 'password123'
end

# 2. Crée un Profil pour l'utilisateur
profile = Profile.find_or_create_by!(user: user) do |p|
  puts "Creating Profile for Josephine Sample"
  p.name = "Josephine Sample"
  p.bio = "The Lead Dev, setting up the foundation for Kitchen Guru!"
end

# 3. Crée une Recette d'exemple liée à l'utilisateur
recipe = Recipe.find_or_create_by!(title: 'Quick Salad', user: user) do |r|
  puts "Creating Sample Recipe: Quick Salad"
  r.description = "A simple, fresh salad perfect for a quick lunch."
  r.prep_time = 10
  r.cook_time = 0
  r.servings = 2
end

puts "Seeding complete."

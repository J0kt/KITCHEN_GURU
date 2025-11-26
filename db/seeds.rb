puts "Seeding the database..."

# 1. Crée un Utilisateur de base (si n'existe pas)
# Note: Devise gère l'encryptage du mot de passe lors de la création
user = User.find_or_create_by!(email: 'jo_sample@example.com') do |u|
  puts "Creating initial User: jo_sample@example.com"
  u.password = 'password123'
  u.password_confirmation = 'password123'
end

# 2. Crée un Profil pour l'utilisateur
# profile = Profile.find_or_create_by!(user: user) do |p|
#   puts "Creating Profile for Josephine Sample"
#   p.name = "Josephine Sample"
#   p.bio = "The Lead Dev, setting up the foundation for Kitchen Guru!"
# end
puts "Seeding the database..."

# Helper: convert "10 min" or "5min" to 10, 5, etc.
puts "Seeding the database..."

def extract_time_minutes(str)
  return nil if str.nil?
  str.to_s[/\d+/].to_i
end

def format_description(data)
  <<~DESC
    Nutritional info:
    #{data[:nutrients]}

    Ingredients:
    #{data[:ingredients]}

    Steps:
    #{data[:steps]}
  DESC
end
# --- 3. Les 10 Recettes ZOE Health / Anti-inflammatoires ---
recipes_source_data = [
  {
    title: 'Morning Chia Seed Bowl with 5 Plants',
    prep_time: '5 min',
    cook_time_str: '0 min',
    nutrients: 'Energy: 350 kcal | Protein: 12g | Fiber: 15g | Fats: 18g (Omega-3)',
    ingredients: "3 tbsp chia seeds\n1 cup almond milk\n1/2 mashed banana (plant 1)\n1 tsp cinnamon (plant 2)\n1/2 cup raspberries (plant 3)\n1 tbsp pecans (plant 4)\n1 tbsp ground flaxseed (plant 5)",
    steps: "1. Mix all ingredients except raspberries in a jar.\n2. Refrigerate for at least 4 hours.\n3. Top with raspberries before serving.",
    saved: true
  },
  {
    title: 'Black Bean, Avocado & Roasted Sweet Potato Salad',
    prep_time: '20 min',
    cook_time_str: '25 min',
    nutrients: 'Energy: 520 kcal | Protein: 25g | Fiber: 18g | Healthy Fats: 28g',
    ingredients: "1 medium sweet potato, roasted and diced (plant 1)\n1 cup black beans, rinsed (plant 2)\n1/2 avocado, sliced (plant 3)\n1/4 cup chopped fresh cilantro (plant 4)\nJuice of half a lime\n1 tbsp extra virgin olive oil\nA pinch of cumin and cayenne pepper (plants 5, 6)",
    steps: "1. Roast the sweet potato (can be done ahead).\n2. In a bowl, combine sweet potato, black beans, and cilantro.\n3. Season with lime juice, olive oil, cumin, and cayenne.\n4. Top with avocado and serve.",
    saved: true
  },
  {
    title: 'Red Lentil & Cauliflower Curry (30-Plants Focus)',
    prep_time: '15 min',
    cook_time_str: '30 min',
    nutrients: 'Energy: 480 kcal | Protein: 22g | Fiber: 17g | Carbs: 60g',
    ingredients: "1 cup red lentils (plant 1)\n3 cups vegetable broth\n1 head cauliflower (plant 2)\n1 chopped onion (plant 3)\n3 garlic cloves (plant 4)\nA nub of fresh ginger (plant 5)\n1 can crushed tomatoes (plant 6)\n1 tbsp curry paste\n1 tsp turmeric (plant 7)",
    steps: "1. Sauté onion, garlic, and ginger in olive oil.\n2. Add curry paste and turmeric.\n3. Add lentils, cauliflower, tomatoes, and broth. Bring to a boil.\n4. Simmer for 30 minutes. Season and serve.",
    saved: true
  },
  {
    title: 'Protein Toast with Homemade Hummus & Summer Veggies',
    prep_time: '10 min',
    cook_time_str: '0 min',
    nutrients: 'Energy: 410 kcal | Protein: 18g | Fiber: 10g | Fats: 20g',
    ingredients: "2 slices gluten-free whole-grain bread (plant 1)\n1/4 cup chickpeas (plant 2)\n1 tsp tahini\nLemon juice\n1 diced tomato (plant 3)\nCucumber slices (plant 4)\nA pinch of oregano and basil (plants 5, 6)",
    steps: "1. Toast the bread.\n2. Mash chickpeas with tahini and lemon to make quick hummus.\n3. Spread on toast and top with tomato and cucumber.",
    saved: false
  },
  {
    title: 'Green Immunity Smoothie with Berries & Spinach',
    prep_time: '5 min',
    cook_time_str: '0 min',
    nutrients: 'Energy: 310 kcal | Protein: 8g | Fiber: 12g | Carbs: 50g',
    ingredients: "1/2 cup oat milk (plant 1)\n1 cup fresh spinach (plant 2)\n1/2 cup blueberries (plant 3)\n1/2 green apple (plant 4)\n1 tsp spirulina\n1 tbsp pumpkin seeds (plant 5)",
    steps: "1. Add all ingredients to a blender.\n2. Blend until smooth.",
    saved: true
  },
  {
    title: 'Carrot & Ginger Soup with Spices',
    prep_time: '15 min',
    cook_time_str: '20 min',
    nutrients: 'Energy: 250 kcal | Protein: 6g | Fiber: 11g | Fats: 12g',
    ingredients: "5 medium carrots (plant 1)\n1 chopped onion\n2 cm fresh ginger, chopped\n4 cups vegetable broth\n1 tsp turmeric\n1 tsp smoked paprika (plant 2)",
    steps: "1. Sauté onion in olive oil.\n2. Add carrots, ginger, and spices; cook 5 min.\n3. Add broth and cook until carrots are tender.\n4. Blend until smooth.",
    saved: false
  },
  {
    title: 'Stir-Fried Brown Rice with Tofu & Tamari',
    prep_time: '10 min',
    cook_time_str: '15 min',
    nutrients: 'Energy: 550 kcal | Protein: 35g | Fiber: 10g | Carbs: 70g',
    ingredients: "1 block firm tofu (plant 1)\n1 cup cooked brown rice (plant 2)\n1/2 red bell pepper (plant 3)\n1/2 broccoli (plant 4)\n2 tbsp tamari\n1 tbsp sesame oil (plant 5)\nA handful of chopped peanuts (plant 6)",
    steps: "1. Brown tofu in sesame oil.\n2. Add pepper and broccoli; cook until tender.\n3. Add rice and tamari; stir.\n4. Serve topped with peanuts.",
    saved: true
  },
  {
    title: 'Buckwheat Pancakes with Apple & Walnuts',
    prep_time: '10 min',
    cook_time_str: '10 min',
    nutrients: 'Energy: 430 kcal | Protein: 10g | Fiber: 8g | Fats: 18g',
    ingredients: "1 cup buckwheat flour (plant 1)\n1 cup plant milk (oat)\n1 egg\n1 tsp baking powder\n1 grated apple (plant 2)\n1/4 cup chopped walnuts (plant 3)\nA pinch of nutmeg (plant 4)",
    steps: "1. Mix dry ingredients.\n2. In another bowl, mix milk, egg, and grated apple.\n3. Combine mixtures and fold in walnuts.\n4. Cook pancakes in a pan.",
    saved: false
  },
  {
    title: 'Fish en Papillote with Mediterranean Vegetables',
    prep_time: '10 min',
    cook_time_str: '20 min',
    nutrients: 'Energy: 400 kcal | Protein: 40g | Fiber: 7g | Fats: 20g',
    ingredients: "1 white fish fillet\n1/2 zucchini (plant 1)\n1/2 yellow bell pepper (plant 2)\n2 tbsp sun-dried tomatoes (plant 3)\n1 tbsp black olives (plant 4)\n1 minced garlic clove\nA drizzle of extra virgin olive oil\nThyme & rosemary (plants 5, 6)",
    steps: "1. Preheat oven to 200°C. Place fish on parchment paper.\n2. Arrange vegetables, olives, and tomatoes around it.\n3. Drizzle with olive oil and sprinkle herbs and garlic.\n4. Close parchment and bake 20 minutes.",
    saved: true
  },
  {
    title: 'Whole-Wheat Pita Filled with Marinated Tempeh',
    prep_time: '10 min',
    cook_time_str: '10 min',
    nutrients: 'Energy: 500 kcal | Protein: 32g | Fiber: 12g | Carbs: 55g',
    ingredients: "1 whole-wheat pita (plant 1)\n1/2 block tempeh (plant 2)\n2 tbsp soy sauce or tamari\n1 tsp maple syrup\n1 cup shredded red cabbage (plant 3)\n1/4 cup fresh parsley (plant 4)",
    steps: "1. Marinate tempeh in tamari and maple syrup.\n2. Pan-fry until golden.\n3. Fill pita with tempeh, red cabbage, and parsley.",
    saved: false
  }
]
# 4. Création des Recettes
recipes_source_data.each do |data|
  Recipe.create!(
    user:        user,
    title:       data[:title],
    description: format_description(data),
    prep_time:   extract_time_minutes(data[:prep_time]),
    cook_time:   extract_time_minutes(data[:cook_time_str]),
    servings:    4 # Default value
    # We ignore data[:saved] because there is no `saved` column in recipes table
  )
  puts "Created recipe: #{data[:title]}"
end
puts "--- Seeding complete. Created #{Recipe.count} recipes. ---"

puts "Seeding complete."

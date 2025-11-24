# 🍳 Kitchen Guru

Kitchen Guru est une application web qui aide les utilisateurs à découvrir et gérer des recettes personnalisées grâce à l'intelligence artificielle.

## 🎯 Fonctionnalités

- 🏠 Page d'accueil accueillante
- 💬 Chat avec l'IA pour obtenir des suggestions de recettes basées sur vos ingrédients
- 📝 Gestion de recettes sauvegardées (voir, éditer, supprimer)
- 👤 Profil utilisateur personnalisé (allergies, préférences, etc.)
- ⭐ Fonctionnalités bonus : variations de recettes, indicateurs nutritionnels, filtres

## 🚀 Getting Started

### Prerequisites

- Ruby 3.1.2
- Rails 7.0+
- PostgreSQL

### Installation

```bash
# Clone le repository
git clone https://github.com/J0kt/KITCHEN_GURU.git
cd KITCHEN_GURU

# Install dependencies
bundle install

# Setup database
rails db:create db:migrate db:seed

# Start server
rails server
```

## 📋 Gestion de Projet

Ce projet utilise un **Kanban board** pour organiser le développement.

### 🎯 Template de Projet

Un template de projet complet est disponible dans `.github/` pour vous aider à :
- Organiser les tâches avec un Kanban (Backlog → Ready → In Progress → In Review → Done)
- Créer des user stories standardisées
- Gérer les bugs et features bonus
- Automatiser certaines tâches avec GitHub Actions

📖 **[Guide du Template de Projet](.github/PROJECT_TEMPLATE_GUIDE.md)**

### Colonnes du Kanban

- 📋 **Backlog** : Tâches à faire
- 🎯 **Ready** : Prêt à être développé
- 🚀 **In progress** : En cours de développement
- 👀 **In review** : En revue de code/tests
- ✅ **Done** : Terminé

### Templates d'Issues

Utilisez les templates pour créer :
- 📝 **User Stories** : Fonctionnalités du point de vue utilisateur
- 🐛 **Bug Reports** : Signaler des problèmes
- ⭐ **Bonus Features** : Proposer des améliorations

## 🛠️ Stack Technique

- **Backend** : Ruby on Rails 7.0
- **Frontend** : HTML, CSS (Bootstrap), JavaScript (Stimulus)
- **Database** : PostgreSQL
- **AI Integration** : OpenAI API (ou similaire)
- **Authentication** : Devise
- **Deployment** : Heroku

## 📚 Documentation

- [Guide du Template de Projet](.github/PROJECT_TEMPLATE_GUIDE.md)
- [Configuration des Workflows](.github/WORKFLOWS_SETUP.md)
- [Exemple de Configuration](.github/project-config-example.json)

## 🤝 Contribution

1. Fork le projet
2. Créez une branche pour votre feature (`git checkout -b feature/AmazingFeature`)
3. Créez une issue en utilisant les templates fournis
4. Ajoutez votre issue au projet Kanban
5. Développez et testez votre fonctionnalité
6. Commit vos changements (`git commit -m 'Add some AmazingFeature'`)
7. Push vers la branche (`git push origin feature/AmazingFeature`)
8. Ouvrez une Pull Request

## 📝 License

Ce projet a été créé dans le cadre de la formation [Le Wagon](https://www.lewagon.com).

Rails app generated with [lewagon/rails-templates](https://github.com/lewagon/rails-templates), created by the [Le Wagon coding bootcamp](https://www.lewagon.com) team.

---

**Happy Cooking! 👨‍🍳👩‍🍳**

# 📋 Guide du Template de Projet Kanban

Ce template de projet Kanban est conçu pour vous aider à organiser et gérer efficacement le développement de vos applications web en utilisant une méthodologie Agile.

## 🎯 Vue d'ensemble

Le template inclut :
- **5 colonnes Kanban** pour suivre l'avancement des tâches
- **Templates d'issues** pour standardiser la création de user stories, bugs et features bonus
- **Labels prédéfinis** pour catégoriser et prioriser le travail
- **Structure réutilisable** pour démarrer rapidement de nouveaux projets

## 📊 Structure du Kanban

### Colonnes

| Colonne | Description | Utilisation |
|---------|-------------|-------------|
| 📋 **Backlog** | This item hasn't been started | Toutes les tâches à faire, non priorisées |
| 🎯 **Ready** | This is ready to be picked up | Tâches prêtes à être prises en charge, priorisées |
| 🚀 **In progress** | This is actively being worked on | Tâches en cours de développement |
| 👀 **In review** | This item is in review | Tâches en cours de revue/test |
| ✅ **Done** | This has been completed | Tâches terminées |

## 🏷️ Labels Disponibles

### Par Type
- `user-story` 🟢 - User story
- `feature` 🔵 - Nouvelle fonctionnalité
- `bug` 🔴 - Problème à corriger
- `bonus` 🟡 - Fonctionnalité bonus
- `enhancement` 🔷 - Amélioration d'une fonctionnalité existante
- `documentation` 🔵 - Documentation

### Par Priorité
- `priority-high` 🔴 - Haute priorité
- `priority-medium` 🟠 - Priorité moyenne
- `priority-low` 🟢 - Basse priorité

## 📝 Templates d'Issues

### 1. User Story
Utilisez ce template pour créer des user stories selon le format standard :
```
As a [type of user], I can [action] so that [benefit]
```

**Champs inclus :**
- Description de la user story
- Critères d'acceptation
- Notes techniques
- Priorité
- Complexité estimée

### 2. Bug Report
Pour signaler des bugs ou problèmes :

**Champs inclus :**
- Description du bug
- Étapes pour reproduire
- Comportement attendu vs actuel
- Screenshots/Logs
- Environnement
- Sévérité

### 3. Bonus Feature
Pour proposer des fonctionnalités bonus :

**Champs inclus :**
- Description de la fonctionnalité
- Motivation/Valeur ajoutée
- Solution proposée
- Alternatives
- Mockups/Exemples
- Impact et effort estimés

## 🚀 Comment utiliser ce template

### Option 1 : Créer un nouveau projet depuis ce template

1. Sur GitHub, allez dans l'onglet **Projects**
2. Cliquez sur **New Project**
3. Sélectionnez **Board** ou **Table** selon votre préférence
4. Importez les colonnes définies dans `project-template.yml`

### Option 2 : Configuration manuelle

1. Créez un nouveau projet GitHub
2. Ajoutez les 5 colonnes dans l'ordre :
   - Backlog
   - Ready
   - In progress
   - In review
   - Done
3. Les templates d'issues seront automatiquement disponibles

### Option 3 : Dupliquer un projet existant

1. Allez dans votre projet Kitchen Guru actuel
2. Cliquez sur les **trois points** (⋯) en haut à droite
3. Sélectionnez **Make a copy**
4. Donnez un nouveau nom à votre projet
5. Archivez ou supprimez les anciennes issues si nécessaire

## 📋 Workflow recommandé

### 1. Création de tâches
- Utilisez les templates d'issues pour créer des user stories
- Ajoutez des labels appropriés (type + priorité)
- Placez-les dans le **Backlog**

### 2. Planification
- Lors de la planification de sprint, déplacez les tâches prioritaires dans **Ready**
- Assignez les tâches aux membres de l'équipe

### 3. Développement
- Déplacez une tâche dans **In progress** quand vous commencez à travailler
- Limitez le nombre de tâches en cours (WIP limit recommandé : 3-5 par personne)

### 4. Revue
- Une fois le développement terminé, déplacez dans **In review**
- Faites une pull request si applicable
- Testez la fonctionnalité

### 5. Complétion
- Une fois validée, déplacez dans **Done**
- Fermez l'issue associée

## 💡 Bonnes pratiques

### User Stories
- Suivez le format "As a [user], I can [action] so that [benefit]"
- Ajoutez des critères d'acceptation clairs et mesurables
- Estimez la complexité avant de commencer
- Décomposez les grandes stories en plus petites (< 5 jours)

### Gestion du Backlog
- Priorisez régulièrement les items dans le backlog
- Gardez les 10-15 premières tâches bien détaillées
- Archivez les anciennes tâches qui ne sont plus pertinentes

### Limites WIP (Work In Progress)
- **In progress** : Maximum 4-5 tâches par personne
- **In review** : Maximum 5 tâches au total
- Si une colonne est pleine, finissez d'abord les tâches existantes

### Reviews
- Toutes les fonctionnalités doivent passer par la colonne **In review**
- Faites des revues de code pour les modifications importantes
- Testez manuellement les nouvelles fonctionnalités

## 🔄 Adaptation du template

Ce template est un point de départ. N'hésitez pas à l'adapter selon vos besoins :

- Ajoutez des colonnes (ex: "Testing", "Deployed to staging")
- Créez de nouveaux labels spécifiques à votre projet
- Modifiez les templates d'issues pour votre contexte
- Ajoutez des automations GitHub Actions

## 📚 Ressources

- [GitHub Projects Documentation](https://docs.github.com/en/issues/planning-and-tracking-with-projects)
- [Agile Best Practices](https://www.atlassian.com/agile)
- [Writing Good User Stories](https://www.mountaingoatsoftware.com/agile/user-stories)

## 🤝 Contribution

Pour améliorer ce template :
1. Proposez vos modifications via une issue
2. Partagez vos retours d'expérience
3. Suggérez de nouveaux templates ou labels

---

**Happy planning! 🚀**

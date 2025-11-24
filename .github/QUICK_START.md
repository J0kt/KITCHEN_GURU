# 🚀 Quick Start - Utiliser le Template de Projet

Guide rapide pour démarrer avec le template de projet Kanban Kitchen Guru.

## 📋 Méthode 1 : Copier le projet existant (RECOMMANDÉ)

C'est la méthode la plus simple pour créer un nouveau projet basé sur le Kanban Kitchen Guru.

### Étapes :

1. **Allez dans le projet Kitchen Guru actuel**
   - Ouvrez GitHub et naviguez vers : `https://github.com/J0kt/projects`
   - Ou depuis le repository, cliquez sur l'onglet **Projects**

2. **Ouvrez votre projet Kanban**
   - Cliquez sur le projet "Kitchen Guru"

3. **Dupliquez le projet**
   - Cliquez sur les **trois points** (⋯) en haut à droite du projet
   - Sélectionnez **"⚙️ Settings"**
   - Scrollez jusqu'à la section **"Danger zone"**
   - Cliquez sur **"Make a copy"**

4. **Configurez le nouveau projet**
   - Donnez un nouveau nom (ex: "Mon Super Projet")
   - Choisissez si vous voulez copier :
     - ✅ Les colonnes et la structure
     - ✅ Les labels
     - ❌ Les items (laissez décoché pour un projet vierge)
   - Cliquez sur **"Copy project"**

5. **Nettoyez le nouveau projet**
   - Si vous avez copié les items par erreur, archivez-les ou supprimez-les
   - Votre nouveau projet Kanban est prêt ! 🎉

## 📋 Méthode 2 : Créer un nouveau projet manuellement

Si vous préférez créer un projet from scratch :

### Étapes :

1. **Créez un nouveau projet**
   - Allez dans l'onglet **Projects** de votre repository
   - Cliquez sur **"New project"**
   - Choisissez **"Board"** comme template
   - Donnez un nom à votre projet

2. **Configurez les colonnes**

   Ajoutez ces 5 colonnes dans l'ordre :

   | Nom | Description |
   |-----|-------------|
   | 📋 Backlog | This item hasn't been started |
   | 🎯 Ready | This is ready to be picked up |
   | 🚀 In progress | This is actively being worked on |
   | 👀 In review | This item is in review |
   | ✅ Done | This has been completed |

3. **Ajoutez les labels**

   Allez dans **Settings** → **Labels** et créez :
   - `user-story` (vert)
   - `feature` (bleu)
   - `bug` (rouge)
   - `bonus` (jaune)
   - `priority-high`, `priority-medium`, `priority-low`

4. **Créez vos premières issues**

   Utilisez les templates dans `.github/ISSUE_TEMPLATE/`

## 🎯 Utiliser les templates d'issues

Une fois votre projet créé :

### Créer une User Story

1. Allez dans l'onglet **Issues**
2. Cliquez sur **"New issue"**
3. Choisissez le template **"User Story"**
4. Remplissez le formulaire :
   - Titre : "As a user I can [ACTION]"
   - Description complète
   - Critères d'acceptation
   - Priorité et complexité
5. Cliquez sur **"Submit new issue"**
6. L'issue sera automatiquement ajoutée à votre projet ! (si workflow configuré)

### Créer un Bug Report

1. **New issue** → Template **"Bug Report"**
2. Remplissez les détails du bug
3. Ajoutez le label `bug`
4. Submit

### Créer une Bonus Feature

1. **New issue** → Template **"Bonus Feature"**
2. Décrivez la fonctionnalité bonus
3. Ajoutez les labels `bonus` et `enhancement`
4. Submit

## 🔄 Workflow recommandé

### Démarrer une nouvelle tâche

1. Dans la colonne **Ready**, choisissez une issue
2. Assignez-vous l'issue
3. Déplacez-la dans **In progress**
4. Créez une branche : `git checkout -b feature/issue-name`
5. Développez !

### Terminer une tâche

1. Commitez vos changements
2. Créez une Pull Request
3. Déplacez l'issue dans **In review**
4. Après validation, mergez la PR
5. L'issue passe automatiquement en **Done** ! (si workflow configuré)

## 🤖 Automatisation (Optionnel)

Pour automatiser l'ajout des issues au projet :

1. Suivez le guide dans [WORKFLOWS_SETUP.md](WORKFLOWS_SETUP.md)
2. Configurez les secrets GitHub (GH_TOKEN et PROJECT_URL)
3. Les nouvelles issues seront automatiquement ajoutées au Backlog

## 💡 Astuces

### Pour les User Stories

```
Format standard :
As a [type of user]
I can [action]
So that [benefit]

Exemple :
As a hungry user
I can search for recipes with available ingredients
So that I don't waste food and save money
```

### Pour les Critères d'acceptation

```
Utilisez des checkboxes :
- [ ] Page accessible depuis le menu
- [ ] Formulaire de recherche fonctionnel
- [ ] Résultats affichés en moins de 2 secondes
- [ ] Design responsive sur mobile
```

### Gestion du Backlog

- Gardez le Backlog organisé (max 20 items visibles)
- Priorisez régulièrement
- Archivez les vieilles issues non pertinentes
- Décomposez les grosses stories (> 5 jours)

## 📊 Utilisation du Kanban

### Limites WIP (Work In Progress)

Recommandations :
- **In progress** : Max 3-5 tâches par personne
- **In review** : Max 5 tâches au total

Si une colonne est pleine, finissez d'abord avant d'ajouter !

### Sprint Planning

1. Choisissez les issues du Backlog
2. Déplacez-les dans Ready
3. Estimez la complexité
4. Assignez aux membres de l'équipe
5. Commencez le sprint !

## 🎓 Ressources

- [📖 Guide complet du template](PROJECT_TEMPLATE_GUIDE.md)
- [🔧 Configuration des workflows](WORKFLOWS_SETUP.md)
- [📋 Exemple de configuration JSON](project-config-example.json)

## ❓ FAQ

**Q : Dois-je utiliser tous les templates ?**
R : Non, utilisez uniquement ceux dont vous avez besoin. Le template User Story est le plus important.

**Q : Puis-je modifier les colonnes ?**
R : Oui ! Ajoutez, supprimez ou renommez les colonnes selon vos besoins.

**Q : Les workflows sont-ils obligatoires ?**
R : Non, ils sont optionnels mais pratiques pour automatiser certaines tâches.

**Q : Comment gérer les dépendances entre issues ?**
R : Utilisez les mentions dans les commentaires (ex: "Dépend de #42") ou les linked issues sur GitHub.

---

**Prêt à démarrer ? Créez votre premier projet maintenant ! 🚀**

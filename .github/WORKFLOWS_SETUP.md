# 🔧 Configuration des Workflows GitHub

Ce guide explique comment configurer les workflows GitHub Actions pour automatiser la gestion de votre projet Kanban.

## 📋 Workflows disponibles

### 1. Auto-add to project (`auto-add-to-project.yml`)

Ce workflow ajoute automatiquement :
- Les nouvelles issues au projet
- Les nouvelles pull requests au projet
- Les labels appropriés aux issues basés sur leur titre

## 🛠️ Configuration

### Étape 1 : Créer un Personal Access Token (PAT)

1. Allez dans **Settings** → **Developer settings** → **Personal access tokens** → **Tokens (classic)**
2. Cliquez sur **Generate new token (classic)**
3. Donnez un nom descriptif (ex: "Project Automation")
4. Sélectionnez les permissions :
   - ✅ `repo` (Full control of private repositories)
   - ✅ `project` (Full control of projects)
   - ✅ `workflow` (Update GitHub Action workflows)
5. Cliquez sur **Generate token**
6. **Copiez le token** (vous ne pourrez plus le voir après !)

### Étape 2 : Ajouter les secrets au repository

1. Allez dans votre repository → **Settings** → **Secrets and variables** → **Actions**
2. Cliquez sur **New repository secret**

#### Secret 1 : GH_TOKEN
- **Name**: `GH_TOKEN`
- **Secret**: Collez votre Personal Access Token créé à l'étape 1

#### Secret 2 : PROJECT_URL
- **Name**: `PROJECT_URL`
- **Secret**: L'URL de votre projet GitHub

**Comment trouver l'URL de votre projet ?**
1. Allez dans l'onglet **Projects** de votre repository
2. Ouvrez votre projet Kanban
3. Copiez l'URL depuis la barre d'adresse

Formats possibles :
- Pour un projet utilisateur : `https://github.com/users/<username>/projects/<project_number>`
- Pour un projet organisation : `https://github.com/orgs/<org>/projects/<project_number>`

Exemple : `https://github.com/users/J0kt/projects/1`

### Étape 3 : Activer les workflows

1. Les workflows sont automatiquement activés une fois les fichiers ajoutés
2. Vous pouvez les voir dans l'onglet **Actions** de votre repository
3. Testez en créant une nouvelle issue

## 🎯 Comportement des automations

### Auto-labeling

Le workflow ajoute automatiquement des labels basés sur le titre de l'issue :

| Condition | Label ajouté |
|-----------|--------------|
| Titre commence par "As a user" | `user-story` |
| Titre contient "(Bonus)" ou "Bonus" | `bonus` |

### Auto-add to project

- **Déclencheur** : Création d'une nouvelle issue ou PR
- **Action** : Ajout automatique à la colonne "Backlog" du projet
- **Avantage** : Plus besoin d'ajouter manuellement les issues au projet

## 🔐 Sécurité

### Bonnes pratiques

1. **Token avec permissions minimales** : Le PAT doit avoir uniquement les permissions nécessaires
2. **Rotation régulière** : Changez votre token tous les 90 jours
3. **Ne partagez jamais** : Ne commitez jamais votre token dans le code
4. **Utilisez des secrets** : Toujours utiliser GitHub Secrets pour les tokens

### En cas de compromission

Si vous pensez que votre token a été compromis :
1. Révoquez immédiatement le token dans GitHub Settings
2. Créez un nouveau token
3. Mettez à jour le secret `GH_TOKEN` dans le repository
4. Vérifiez les logs d'activité pour toute action suspecte

## 🚀 Workflows supplémentaires possibles

Voici d'autres automations que vous pourriez ajouter :

### Auto-move on PR creation
```yaml
# Déplace automatiquement l'issue en "In review" quand une PR est créée
on:
  pull_request:
    types: [opened]
```

### Auto-close on merge
```yaml
# Ferme l'issue et la déplace en "Done" quand la PR est mergée
on:
  pull_request:
    types: [closed]
```

### Stale issue management
```yaml
# Marque les issues inactives et les ferme après un délai
uses: actions/stale@v8
```

### Automatic assignment
```yaml
# Assigne automatiquement les issues selon certains critères
```

## 📊 Monitoring

Pour vérifier que les workflows fonctionnent :

1. Allez dans **Actions** → Sélectionnez un workflow
2. Consultez les runs récents
3. Vérifiez les logs en cas d'erreur

### Erreurs communes

| Erreur | Solution |
|--------|----------|
| "Bad credentials" | Vérifiez que `GH_TOKEN` est correct |
| "Resource not accessible" | Vérifiez les permissions du PAT |
| "Project not found" | Vérifiez l'URL du projet dans `PROJECT_URL` |

## 💡 Customisation

Pour personnaliser les workflows selon vos besoins :

1. Éditez les fichiers dans `.github/workflows/`
2. Ajustez les déclencheurs (`on:`)
3. Modifiez les actions et conditions
4. Testez en créant une issue de test

## 🔗 Ressources

- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Workflow syntax](https://docs.github.com/en/actions/reference/workflow-syntax-for-github-actions)
- [Managing secrets](https://docs.github.com/en/actions/security-guides/encrypted-secrets)

---

**Need help?** Consultez la [documentation GitHub Projects](https://docs.github.com/en/issues/planning-and-tracking-with-projects) ou créez une issue ! 🚀

# 📚 SkyzerFusionCore - Quest System Wiki

**Version:** 1.0
**Minecraft:** 1.12.2
**Forge:** 14.23.5.2864

---

## 📖 Table des Matières

1. [Introduction](#introduction)
2. [Architecture du Système](#architecture)
3. [Quest Goals (Objectifs)](#quest-goals)
4. [Quest Rewards (Récompenses)](#quest-rewards)
5. [Quest Properties](#quest-properties)
6. [⭐ Metadata Support (1.12.2)](#metadata-support)
7. [Shop System](#shop-system)
8. [Reward Tables](#reward-tables)
9. [JSON Examples](#json-examples)
10. [Java API](#java-api)

---

## 🎮 Introduction

Le Quest System de SkyzerFusionCore est un système de quêtes complet avec :
- ✅ **Toutes les quêtes actives simultanément** pour tous les joueurs
- ✅ Progression automatique basée sur les actions en jeu
- ✅ Support complet des **metadata Minecraft 1.12.2** (variants d'items/blocks)
- ✅ Système de dépendances entre quêtes
- ✅ Reward tables avec loot aléatoire
- ✅ Shop admin avec buy/sell
- ✅ Interface web moderne avec canvas interactif

---

## 🏗️ Architecture

### Structure des Fichiers

```
world/skyzerquest/
├── config.json                    # Configuration globale
├── shop.json                      # Système de shop
├── groups/
│   └── *.json                     # Groupes de quêtes
├── chapters/
│   └── chapter_id/                # Dossier par chapitre
│       ├── chapter.json           # Métadonnées du chapitre
│       └── quests/
│           └── *.json             # Quêtes du chapitre
└── reward_tables/
    └── *.json                     # Tables de récompenses
```

### Hiérarchie

```
QuestGroups (Groupes)
  └─ QuestChapters (Chapitres)
       └─ Quests (Quêtes)
            ├─ Goals (Objectifs)
            └─ Rewards (Récompenses)
```

---

## 🎯 Quest Goals

### Types de Goals Disponibles

#### 1. **collect** - Collecter des items
Demande au joueur d'avoir des items dans son inventaire.

**Paramètres :**
- `item` : ID de l'item (supporte metadata)
- `amount` : Quantité requise
- `consume` : Consommer les items à la complétion (true/false)
- `meta` ou `metadata` : Variant de l'item (optionnel)
- `nbt` : Données NBT pour items enchantés, renommés, etc. (optionnel)
- `display_name` : Nom affiché (optionnel)

**Exemple - Collect Oak Wood :**
```json
{
  "type": "collect",
  "item": "minecraft:log",
  "amount": 64,
  "consume": true
}
```

**Exemple - Collect Spruce Wood (metadata 1) :**
```json
{
  "type": "collect",
  "item": "minecraft:log:1",
  "amount": 64,
  "consume": true
}
```

**Exemple - Collect Sharpness V Diamond Sword (NBT) :**
```json
{
  "type": "collect",
  "item": "minecraft:diamond_sword",
  "amount": 1,
  "consume": false,
  "nbt": "{Enchantments:[{id:\"sharpness\",lvl:5}]}"
}
```

#### 2. **craft** - Crafter des items
Détecte quand le joueur craft des items spécifiques.

**Paramètres :**
- `item` : ID de l'item (supporte metadata)
- `amount` : Quantité à crafter
- `meta` ou `metadata` : Variant (optionnel)
- `nbt` : Données NBT pour items spéciaux (optionnel)

**Exemple - Craft 16 Sticks :**
```json
{
  "type": "craft",
  "item": "minecraft:stick",
  "amount": 16
}
```

**Exemple - Craft Blue Wool (metadata 11) :**
```json
{
  "type": "craft",
  "item": "minecraft:wool:11",
  "amount": 32
}
```

**Exemple - Craft Fortune III Enchanted Book (NBT) :**
```json
{
  "type": "craft",
  "item": "minecraft:enchanted_book",
  "amount": 1,
  "nbt": "{StoredEnchantments:[{id:\"fortune\",lvl:3}]}"
}
```

#### 3. **break** - Casser des blocks
Compte les blocks cassés par le joueur.

**Paramètres :**
- `block` : ID du block (supporte metadata)
- `amount` : Quantité à casser
- `meta` ou `metadata` : Variant du block (optionnel)

**Exemple - Break 100 Stone :**
```json
{
  "type": "break",
  "block": "minecraft:stone",
  "amount": 100
}
```

**Exemple - Break Birch Wood (metadata 2) :**
```json
{
  "type": "break",
  "block": "minecraft:log:2",
  "amount": 100
}
```

#### 4. **place** - Placer des blocks
Compte les blocks placés par le joueur.

**Paramètres :**
- `block` : ID du block (supporte metadata)
- `amount` : Quantité à placer
- `meta` ou `metadata` : Variant du block (optionnel)

**Exemple - Place 50 Torches :**
```json
{
  "type": "place",
  "block": "minecraft:torch",
  "amount": 50
}
```

**Exemple - Place Orange Wool (metadata 1) :**
```json
{
  "type": "place",
  "block": "minecraft:wool:1",
  "amount": 64
}
```

#### 5. **kill** - Tuer des mobs
Compte les entités tuées par le joueur.

**Paramètres :**
- `entity` : ID de l'entité
- `amount` : Quantité à tuer

**Exemple - Kill 50 Zombies :**
```json
{
  "type": "kill",
  "entity": "minecraft:zombie",
  "amount": 50
}
```

#### 6. **walking** - Marcher une distance
Mesure la distance parcourue par le joueur.

**Paramètres :**
- `distance` : Distance en blocks

**Exemple - Walk 1000 blocks :**
```json
{
  "type": "walking",
  "distance": 1000
}
```

#### 7. **explore_biome** - Explorer un biome
Demande au joueur de visiter un biome spécifique.

**Paramètres :**
- `biome` : ID du biome Minecraft

**Exemple - Explore Desert :**
```json
{
  "type": "explore_biome",
  "biome": "minecraft:desert"
}
```

#### 8. **explore_dimension** - Explorer une dimension
Demande au joueur de visiter une dimension.

**Paramètres :**
- `dimension` : ID de la dimension (0=Overworld, -1=Nether, 1=End)

**Exemple - Go to Nether :**
```json
{
  "type": "explore_dimension",
  "dimension": -1
}
```

---

## 🎁 Quest Rewards

### Types de Rewards Disponibles

#### 1. **money** - Argent
Donne de l'argent au joueur.

**Paramètres :**
- `amount` : Montant fixe, OU
- `min` et `max` : Montant aléatoire entre min et max

**Exemple - 1000$ fixe :**
```json
{
  "type": "money",
  "amount": 1000.0
}
```

**Exemple - Entre 500$ et 1500$ :**
```json
{
  "type": "money",
  "min": 500.0,
  "max": 1500.0
}
```

#### 2. **xp** - Points d'XP
Donne des points d'expérience Minecraft.

**Paramètres :**
- `amount` : Points fixes, OU
- `min` et `max` : Points aléatoires

**Exemple - 100 XP :**
```json
{
  "type": "xp",
  "amount": 100
}
```

#### 3. **xp_level** - Niveaux d'XP
Donne des niveaux d'expérience complets.

**Paramètres :**
- `amount` : Niveaux fixes, OU
- `min` et `max` : Niveaux aléatoires

**Exemple - 5 niveaux :**
```json
{
  "type": "xp_level",
  "amount": 5
}
```

#### 4. **item** - Items
Donne des items au joueur (supporte metadata).

**Paramètres :**
- `item` : ID de l'item (supporte metadata)
- `amount` : Quantité
- `meta` ou `metadata` : Variant (optionnel)
- `nbt` : Données NBT (optionnel)
- `display_name` : Nom personnalisé (optionnel)

**Exemple - 64 Diamond :**
```json
{
  "type": "item",
  "item": "minecraft:diamond",
  "amount": 64
}
```

**Exemple - 16 Spruce Wood (metadata 1) :**
```json
{
  "type": "item",
  "item": "minecraft:log:1",
  "amount": 16
}
```

#### 5. **command** - Commande
Execute une commande serveur.

**Paramètres :**
- `command` : Commande à exécuter (`{player}` = nom du joueur)

**Exemple - Téléportation :**
```json
{
  "type": "command",
  "command": "tp {player} 0 100 0"
}
```

#### 6. **reward_table** - Table de loot
Tire des récompenses aléatoires depuis une table.

**Paramètres :**
- `table_id` : ID de la reward table
- `rolls` : Nombre de tirages (défaut: 1)

**Exemple - 3 items aléatoires :**
```json
{
  "type": "reward_table",
  "table_id": "rare_loot",
  "rolls": 3
}
```

---

## ⚙️ Quest Properties

### Exemple de Quête Complète

```json
{
  "id": "quest_wood_collection",
  "title": "Wood Collector",
  "description": "Collect different types of wood to start your adventure.",

  "icon": {
    "item": "minecraft:log:1"
  },

  "shape": "hexagon",

  "colors": {
    "background": "#2D5016",
    "border": "#8BC34A",
    "text": "#FFFFFF"
  },

  "position": {
    "x": 100,
    "y": 50
  },

  "dependencies": {
    "type": "all_required",
    "quests": ["quest_starter"]
  },

  "repeatable": false,
  "cooldown": 0,
  "hidden_until_unlocked": false,

  "goals": [
    {
      "type": "collect",
      "item": "minecraft:log",
      "amount": 64,
      "consume": true
    },
    {
      "type": "collect",
      "item": "minecraft:log:1",
      "amount": 32,
      "consume": true
    }
  ],

  "rewards": [
    {
      "type": "money",
      "amount": 500.0
    },
    {
      "type": "xp_level",
      "amount": 2
    },
    {
      "type": "item",
      "item": "minecraft:diamond_axe",
      "amount": 1
    }
  ]
}
```

### Shapes Disponibles
- `square` (carré)
- `circle` (cercle)
- `hexagon` (hexagone)
- `diamond` (losange)
- `octagon` (octogone)

### Dependency Types
- `all_required` : Toutes les quêtes dépendances doivent être complétées
- `one_required` : Une seule quête dépendance suffit

---

## ⭐ Metadata Support (1.12.2)

### 🔍 Pourquoi les Metadata ?

En Minecraft 1.12.2, beaucoup d'items/blocks partagent le même ID mais ont des **variants** via metadata :
- `minecraft:log:0` = Oak Wood
- `minecraft:log:1` = Spruce Wood
- `minecraft:log:2` = Birch Wood
- `minecraft:log:3` = Jungle Wood

**Sans metadata, le système ne peut pas différencier les variants !**

### 📝 Formats Supportés

Le système accepte **3 formats** pour spécifier des metadata :

#### Format 1 : Colon-separated (✅ Recommandé)
```json
{
  "item": "minecraft:log:1"
}
```

#### Format 2 : Champ séparé "meta"
```json
{
  "item": "minecraft:log",
  "meta": 1
}
```

#### Format 3 : Champ "metadata"
```json
{
  "item": "minecraft:log",
  "metadata": 1
}
```

### 📊 Items Courants avec Metadata

| Item | Meta 0 | Meta 1 | Meta 2 | Meta 3 | Meta 4+ |
|------|--------|--------|--------|--------|---------|
| **log** | Oak | Spruce | Birch | Jungle | - |
| **log2** | Acacia | Dark Oak | - | - | - |
| **planks** | Oak | Spruce | Birch | Jungle | Acacia (4), Dark Oak (5) |
| **wool** | White | Orange | Magenta | Lt Blue | Yellow (4)... |
| **stone** | Stone | Granite | Pol Gran | Diorite | Pol Dio (4)... |
| **dirt** | Dirt | Coarse | Podzol | - | - |
| **sand** | Sand | Red Sand | - | - | - |
| **sandstone** | Normal | Chiseled | Smooth | - | - |
| **leaves** | Oak | Spruce | Birch | Jungle | - |
| **sapling** | Oak | Spruce | Birch | Jungle | Acacia (4), Dark Oak (5) |

### 🎨 Wool Colors (0-15)

| Meta | Color | Meta | Color |
|------|-------|------|-------|
| 0 | White | 8 | Light Gray |
| 1 | Orange | 9 | Cyan |
| 2 | Magenta | 10 | Purple |
| 3 | Light Blue | 11 | Blue |
| 4 | Yellow | 12 | Brown |
| 5 | Lime | 13 | Green |
| 6 | Pink | 14 | Red |
| 7 | Gray | 15 | Black |

### 💡 Exemples Pratiques

**Goal: Collect uniquement Spruce Wood :**
```json
{
  "type": "collect",
  "item": "minecraft:log:1",
  "amount": 64,
  "consume": true
}
```

**Goal: Break Red Sand (pas Yellow Sand) :**
```json
{
  "type": "break",
  "block": "minecraft:sand:1",
  "amount": 100
}
```

**Goal: Craft Orange Wool :**
```json
{
  "type": "craft",
  "item": "minecraft:wool:1",
  "amount": 16
}
```

**Reward: 16 Jungle Wood :**
```json
{
  "type": "item",
  "item": "minecraft:log:3",
  "amount": 16
}
```

**Shop Item - Blue Wool :**
```json
{
  "id": "blue_wool",
  "item": "minecraft:wool:11",
  "amount": 1,
  "buy_price": 5.00,
  "sell_price": 2.50
}
```

**Quest Icon - Birch Log :**
```json
{
  "icon": {
    "item": "minecraft:log:2"
  }
}
```

**Quest Icon - AE2 Facade with NBT :**
```json
{
  "icon": {
    "item": "appliedenergistics2:facade",
    "nbt": "{item:\"minecraft:stone\"}"
  }
}
```

### ⚠️ Metadata 0 = Défaut

Si aucun metadata n'est spécifié, le système utilise automatiquement `meta = 0`.

```json
// Ces deux formats sont équivalents
{"item": "minecraft:log"}
{"item": "minecraft:log:0"}
```

### 🔧 Vérification En Jeu

Pour tester les metadata en jeu :
```
/give @p minecraft:log 1 0    # Oak Wood
/give @p minecraft:log 1 1    # Spruce Wood
/give @p minecraft:log 1 2    # Birch Wood
/give @p minecraft:log 1 3    # Jungle Wood
```

---

## 🏷️ NBT Support

### 🔍 Qu'est-ce que NBT ?

NBT (Named Binary Tag) permet de stocker des données complexes sur les items :
- **Enchantements** (épées enchantées, livres enchantés)
- **Noms personnalisés** (items renommés dans une anvil)
- **Items spéciaux** (facades AE2, items modded avec données)
- **Attributs custom** (durabilité, couleur, etc.)

### 📝 Où NBT est supporté

| Feature | Support NBT | Exemple |
|---------|-------------|---------|
| Quest icons | ✅ | Afficher une facade AE2 avec NBT |
| `collect` goal | ✅ | Collecter une épée avec Sharpness V |
| `craft` goal | ✅ | Crafter un livre enchanté spécifique |
| `item` reward | ✅ | Donner une épée enchantée |
| Reward tables | ✅ | Loot avec items enchantés |
| Shop items | ✅ | Vendre/acheter des items enchantés |
| Item Icons API | ✅ | `/api/items/icon/diamond_sword?nbt=...` |
| `break` goal | ❌ | Les blocks n'utilisent pas NBT (metadata seulement) |
| `place` goal | ❌ | Les blocks n'utilisent pas NBT (metadata seulement) |

### 📊 Exemples d'utilisation

#### Item enchanté (Sharpness V)
```json
{
  "type": "item",
  "item": "minecraft:diamond_sword",
  "amount": 1,
  "nbt": "{Enchantments:[{id:\"sharpness\",lvl:5}]}"
}
```

#### Livre enchanté (Fortune III)
```json
{
  "type": "item",
  "item": "minecraft:enchanted_book",
  "amount": 1,
  "nbt": "{StoredEnchantments:[{id:\"fortune\",lvl:3}]}"
}
```

#### Item renommé
```json
{
  "type": "item",
  "item": "minecraft:diamond_sword",
  "amount": 1,
  "nbt": "{display:{Name:\"§6Excalibur\"}}"
}
```

#### Facade AE2
```json
{
  "icon": {
    "item": "appliedenergistics2:facade",
    "nbt": "{item:\"minecraft:stone\",meta:0}"
  }
}
```

#### Goal collect avec NBT
```json
{
  "type": "collect",
  "item": "minecraft:diamond_pickaxe",
  "amount": 1,
  "consume": false,
  "nbt": "{Enchantments:[{id:\"efficiency\",lvl:5},{id:\"unbreaking\",lvl:3}]}"
}
```

#### Potions
```json
{
  "type": "item",
  "item": "minecraft:potion",
  "amount": 1,
  "nbt": "{Potion:\"minecraft:long_swiftness\"}"
}
```

#### Livres écrits
```json
{
  "type": "item",
  "item": "minecraft:written_book",
  "amount": 1,
  "nbt": "{title:\"Guide de Quête\",author:\"Skyzer\",pages:[\"Page 1\",\"Page 2\"]}"
}
```

#### Multiples enchantements
```json
{
  "type": "item",
  "item": "minecraft:diamond_sword",
  "amount": 1,
  "nbt": "{Enchantments:[{id:\"minecraft:sharpness\",lvl:5},{id:\"minecraft:looting\",lvl:3},{id:\"minecraft:unbreaking\",lvl:3}]}"
}
```

### ⚙️ Format NBT

Le NBT doit être en format **JSON stringifié** :
- Utiliser des guillemets doubles `"` pour les clés et valeurs
- Ne PAS mettre d'espaces inutiles
- Respecter la syntaxe NBT de Minecraft 1.12.2

**Bon format :**
```json
"{Enchantments:[{id:\"sharpness\",lvl:5}]}"
```

**Mauvais format :**
```json
{Enchantments:[{id:'sharpness',lvl:5}]}  ❌ (pas de guillemets autour)
```

### 🔧 Tester NBT en jeu

```bash
# Donner une épée avec Sharpness V
/give @p minecraft:diamond_sword 1 0 {Enchantments:[{id:"sharpness",lvl:5}]}

# Donner un livre avec Fortune III
/give @p minecraft:enchanted_book 1 0 {StoredEnchantments:[{id:"fortune",lvl:3}]}

# Item renommé
/give @p minecraft:diamond 1 0 {display:{Name:"§bSuper Diamant"}}
```

### 📌 Notes importantes

1. **Metadata ET NBT** peuvent être utilisés ensemble :
```json
{
  "item": "minecraft:log:1",
  "meta": 1,
  "nbt": "{display:{Name:\"§eSpecial Spruce\"}}"
}
```

2. **Localized names** respectent le NBT (enchantements visibles, noms custom)

3. **Shop items** avec NBT affichent la vraie icône et le vrai nom

4. **Web API** supporte NBT via query parameter URL-encoded :
```javascript
// Helper function
function getIconUrl(itemId, metadata, nbt) {
    const params = [];
    if (metadata !== 0) params.push(`meta=${metadata}`);
    if (nbt) params.push(`nbt=${encodeURIComponent(nbt)}`);
    const queryString = params.length > 0 ? '?' + params.join('&') : '';
    return `/api/items/icon/${itemId}${queryString}`;
}

// Exemple: Épée Sharpness V
const url = getIconUrl('minecraft:diamond_sword', 0, '{Enchantments:[{id:"sharpness",lvl:5}]}');
// Retourne: /api/items/icon/diamond_sword?nbt=%7BEnchantments%3A...
```

### ⚠️ Validation NBT

**Erreurs courantes :**
- ❌ `{id:sharpness,lvl:5}` - Oublier les guillemets
- ✅ `{id:"sharpness",lvl:5}` - Correct
- ❌ `(Enchantments:...)` - Mauvais brackets
- ✅ `{Enchantments:[...]}` - Correct
- ❌ `{id:"sharp",lvl:5}` - ID invalide
- ✅ `{id:"minecraft:sharpness",lvl:5}` - Correct avec namespace

**Debug :** Si NBT ne fonctionne pas, vérifier les logs serveur pour les erreurs de parsing NBT.

### 🚀 Performance

- NBT matching est plus coûteux que metadata matching
- Utiliser metadata quand possible (types de bois, couleurs de laine)
- Utiliser NBT seulement pour les cas spéciaux (enchantements, items modded)
- Éviter les structures NBT trop complexes dans les goals

### 🔍 Obtenir NBT depuis le jeu

**Méthode 1 : F3+H (Advanced Tooltips)**
- Activer F3+H en jeu
- Survoler l'item dans l'inventaire
- Voir les données NBT affichées

**Méthode 2 : Commandes**
```bash
# Obtenir NBT de l'item tenu
/entitydata @p {SelectedItem:{}}

# NBT Editor (mod externe) pour 1.12.2
# Permet de copier/coller NBT facilement
```

---

## 🏪 Shop System

### Configuration Shop

Le shop est configurable dans `config.json` :

```json
{
  "shop_settings": {
    "enable_shop": true,
    "shop_transaction_fee": 0.05,
    "allow_sell_without_buy_price": true,
    "default_no_price_value": 0.0
  }
}
```

### Shop Categories

**Fichier:** `world/skyzerquest/shop.json`

```json
{
  "categories": [
    {
      "id": "building",
      "name": "Building Blocks",
      "icon": "minecraft:stone",
      "display_order": 1,
      "items": [
        {
          "id": "oak_log",
          "item": "minecraft:log",
          "amount": 1,
          "buy_price": 10.0,
          "sell_price": 5.0,
          "stock": -1,
          "max_stack_per_transaction": 64
        },
        {
          "id": "spruce_log",
          "item": "minecraft:log:1",
          "amount": 1,
          "buy_price": 12.0,
          "sell_price": 6.0,
          "stock": -1
        }
      ]
    }
  ]
}
```

### Shop Item Properties

- `id` : Identifiant unique
- `item` : ID de l'item (supporte metadata)
- `meta` : Variant (optionnel si colon-separated)
- `amount` : Quantité par transaction
- `buy_price` : Prix d'achat (-1 = non achetable)
- `sell_price` : Prix de vente (-1 = non vendable)
- `stock` : Stock disponible (-1 = illimité)
- `max_stack_per_transaction` : Max par achat (défaut: 64)
- `display_name` : Nom personnalisé (optionnel)

---

## 🎲 Reward Tables

Les reward tables permettent de donner des récompenses aléatoires.

**Fichier:** `world/skyzerquest/reward_tables/common_loot.json`

```json
{
  "id": "common_loot",
  "name": "Common Loot",
  "description": "Basic rewards for early quests",

  "entries": [
    {
      "item": "minecraft:diamond",
      "amount": 3,
      "weight": 10
    },
    {
      "item": "minecraft:gold_ingot",
      "amount": 8,
      "weight": 25
    },
    {
      "item": "minecraft:iron_ingot",
      "amount": 16,
      "weight": 40
    },
    {
      "item": "minecraft:coal",
      "amount": 32,
      "weight": 25
    }
  ]
}
```

**Weight (Poids) :**
- Plus le weight est élevé, plus l'item a de chances d'être tiré
- Dans l'exemple : Iron Ingot a 40/(10+25+40+25) = 40% de chances

---

## 📋 JSON Examples

### Exemple 1 : Quête Simple

```json
{
  "id": "first_steps",
  "title": "First Steps",
  "description": "Collect your first wood and craft basic tools.",

  "icon": {
    "item": "minecraft:log"
  },

  "position": {
    "x": 0,
    "y": 0
  },

  "goals": [
    {
      "type": "collect",
      "item": "minecraft:log",
      "amount": 10,
      "consume": false
    },
    {
      "type": "craft",
      "item": "minecraft:wooden_pickaxe",
      "amount": 1
    }
  ],

  "rewards": [
    {
      "type": "money",
      "amount": 100.0
    }
  ]
}
```

### Exemple 2 : Quête avec Metadata (Tous les types de bois)

```json
{
  "id": "wood_specialist",
  "title": "Wood Specialist",
  "description": "Collect all types of wood logs.",

  "icon": {
    "item": "minecraft:log:0"
  },

  "goals": [
    {
      "type": "collect",
      "item": "minecraft:log:0",
      "amount": 16,
      "consume": true,
      "display_name": "Oak Wood"
    },
    {
      "type": "collect",
      "item": "minecraft:log:1",
      "amount": 16,
      "consume": true,
      "display_name": "Spruce Wood"
    },
    {
      "type": "collect",
      "item": "minecraft:log:2",
      "amount": 16,
      "consume": true,
      "display_name": "Birch Wood"
    },
    {
      "type": "collect",
      "item": "minecraft:log:3",
      "amount": 16,
      "consume": true,
      "display_name": "Jungle Wood"
    }
  ],

  "rewards": [
    {
      "type": "money",
      "min": 500.0,
      "max": 1000.0
    },
    {
      "type": "xp_level",
      "amount": 5
    }
  ]
}
```

### Exemple 3 : Wool Rainbow Quest

```json
{
  "id": "rainbow_wool",
  "title": "Rainbow Collector",
  "description": "Collect all 16 wool colors!",

  "icon": {
    "item": "minecraft:wool:14"
  },

  "goals": [
    {"type": "collect", "item": "minecraft:wool:0", "amount": 8, "consume": true},
    {"type": "collect", "item": "minecraft:wool:1", "amount": 8, "consume": true},
    {"type": "collect", "item": "minecraft:wool:2", "amount": 8, "consume": true},
    {"type": "collect", "item": "minecraft:wool:3", "amount": 8, "consume": true},
    {"type": "collect", "item": "minecraft:wool:4", "amount": 8, "consume": true},
    {"type": "collect", "item": "minecraft:wool:5", "amount": 8, "consume": true},
    {"type": "collect", "item": "minecraft:wool:6", "amount": 8, "consume": true},
    {"type": "collect", "item": "minecraft:wool:7", "amount": 8, "consume": true},
    {"type": "collect", "item": "minecraft:wool:8", "amount": 8, "consume": true},
    {"type": "collect", "item": "minecraft:wool:9", "amount": 8, "consume": true},
    {"type": "collect", "item": "minecraft:wool:10", "amount": 8, "consume": true},
    {"type": "collect", "item": "minecraft:wool:11", "amount": 8, "consume": true},
    {"type": "collect", "item": "minecraft:wool:12", "amount": 8, "consume": true},
    {"type": "collect", "item": "minecraft:wool:13", "amount": 8, "consume": true},
    {"type": "collect", "item": "minecraft:wool:14", "amount": 8, "consume": true},
    {"type": "collect", "item": "minecraft:wool:15", "amount": 8, "consume": true}
  ],

  "rewards": [
    {
      "type": "money",
      "amount": 2000.0
    },
    {
      "type": "item",
      "item": "minecraft:diamond",
      "amount": 10
    }
  ]
}
```

---

## 💻 Java API

### QuestManager - Gestionnaire Principal

```java
// Get singleton instance
QuestManager manager = QuestManager.getInstance();

// Get all quests
List<Quest> allQuests = manager.getAllQuests();

// Get quest by ID
Quest quest = manager.getQuestById("quest_id");

// Check if player can start quest
boolean canStart = manager.canStartQuest(player, quest);

// Get player's active quests
Map<String, QuestProgress> activeQuests = manager.getActiveQuests(player);

// Get player's completed quests
Set<String> completed = manager.getCompletedQuests(player);

// Claim quest rewards
manager.claimRewards(player, quest);
```

### DatabaseManager - Accès aux Données

```java
// Get singleton
DatabaseManager db = DatabaseManager.getInstance();

// Get player data
PlayerData data = db.getPlayerData(playerUUID);

// Get/modify money
double money = data.getMoney();
data.addMoney(1000.0);
data.removeMoney(500.0);

// Save player data
db.savePlayerData(data);
```

### ItemStackHelper - Parsing Metadata

```java
// Parse ItemStack from JSON with metadata
JsonObject json = new JsonObject();
json.addProperty("item", "minecraft:log:1");
json.addProperty("amount", 64);
ItemStack stack = ItemStackHelper.parseItemStack(json);

// Check if items match (including metadata)
boolean matches = ItemStackHelper.itemsMatch(stack1, stack2, checkNBT);

// Get string representation with metadata
String itemString = ItemStackHelper.getItemStackString(stack);
// Returns: "minecraft:log:1"
```

---

## 🌐 Web Interface

### Accès

L'interface web se lance automatiquement :
- **URL:** `http://localhost:8765/?token=<auth_token>`
- Le token est affiché en console au démarrage

### API Endpoints

```
GET  /api/player/me              - Infos du joueur
GET  /api/player/inventory       - Inventaire avec metadata
GET  /api/quests                 - Liste de toutes les quêtes
GET  /api/shop/categories        - Catégories du shop
POST /api/shop/buy               - Acheter un item
POST /api/shop/sell              - Vendre un item
GET  /api/items/icon/:item?meta=X - Icône avec metadata
```

**Exemple Icon URL avec metadata:**
```
/api/items/icon/log?meta=1    # Spruce Wood
/api/items/icon/wool?meta=11  # Blue Wool
```

---

## 🔍 Troubleshooting

### Quest ne progresse pas

1. Vérifier que la quête n'est pas déjà complétée
2. Vérifier les dépendances (prerequisites)
3. **Vérifier le metadata** si c'est un goal collect/craft/break/place
4. Checker les logs : `logs/latest.log`

### Metadata ne fonctionne pas

1. Utiliser le format `"minecraft:log:1"` (colon-separated recommandé)
2. Vérifier que le metadata existe pour cet item en 1.12.2
3. Tester avec `/give @p minecraft:log 1 1` en jeu
4. Consulter le tableau des metadata ci-dessus

### Item icon ne s'affiche pas correctement

1. Vérifier que l'item existe : `/give @p <item>`
2. Si c'est un variant, ajouter `?meta=X` à l'URL
3. Vérifier les logs du serveur web

---

## 📚 Ressources

### Documentation Minecraft 1.12.2
- **Forge Docs:** http://mcforge.readthedocs.io/en/1.12.x/
- **Item IDs:** https://minecraft-ids.grahamedgecombe.com/
- **Metadata Values:** https://minecraft.fandom.com/wiki/Java_Edition_data_values/Pre-flattening

---

**Dernière mise à jour:** 9 février 2026
**Auteur:** SkyzerFusionCore Team
**Version:** 1.0-SNAPSHOT-1.12.2

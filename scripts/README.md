# Skyzer Adventure - CraftTweaker Scripts

This folder contains all the custom recipe modifications for the Skyzer Adventure modpack.

## Script Overview

### Load Order (Priority)
Scripts are loaded in order of priority (higher number = loads first):

1. **00_globals.zs** (Priority 9999)
   - Defines global variables and progression gates
   - Used by all other scripts

2. **01_tier_progression.zs** (Priority 9000)
   - Forces tech progression: Thermal → Mekanism → AE2 → Draconic Evolution
   - Ensures players don't skip tiers

3. **02_tech_magic_synergy.zs** (Priority 8000)
   - Creates hybrid recipes requiring BOTH tech and magic
   - Mystical Agriculture tier progression
   - Energy conversion systems

4. **03_spatial_progression.zs** (Priority 7000)
   - Forces planetary exploration for key resources
   - Rocket tier gating
   - Exotic planet resource requirements

5. **04_balance_tweaks.zs** (Priority 6000)
   - General balance adjustments
   - Makes unobtainable vanilla items craftable
   - Nerfs overpowered early game items

6. **05_ore_unification.zs** (Priority 5000)
   - Unifies duplicate ores/ingots from different mods
   - Prevents inventory clutter
   - Sets standard materials for each resource

## Progression Path

### Tier 1 - Early Game
- **Magic Gate**: Botania Petals
- **Tech Gate**: Copper Ingot (Thermal Foundation)
- **Focus**: Basic automation, mana generation

### Tier 2 - Development
- **Magic Gate**: Manasteel
- **Tech Gate**: Basic Machine Frame (Thermal)
- **Focus**: Mekanism machines, AE2 basics, Wizardry

### Tier 3 - Space Preparation
- **Magic Gate**: Terrasteel
- **Tech Gate**: Steel Casing (Mekanism)
- **Focus**: Galacticraft, Moon missions

### Tier 4 - Spatial Exploration
- **Magic Gate**: Dragonstone
- **Tech Gate**: Heavy-Duty Plate (Galacticraft)
- **Focus**: Mars, advanced planets, Draconic Evolution basics

### Tier 5 - End Game
- **Magic Gate**: Gaia Spirit
- **Tech Gate**: Draconic Core
- **Focus**: Ultimate tech/magic, dimensional exploration

## Mod Synergy Examples

### Mystical Agriculture
- Tier 1 Seeds: Require Botania petals
- Tier 2 Seeds: Require Mana Infusion
- Tier 3 Seeds: Require Thermal machines + Botania
- Tier 4 Seeds: Require Mekanism circuits + Terrasteel
- Tier 5 Seeds: Require Gaia Spirit + Draconic Core

### Spatial Progression
- Tier 1 Rocket: Mekanism Enriched Alloy + Thermal components
- Tier 2 Rocket: Moon resources + AE2 circuits
- Tier 3 Rocket: Mars Desh + Terrasteel
- End Game Tech: Requires exotic planet resources

### Energy Systems
- Mana ↔ RF conversion available mid-game
- Advanced tech requires both energy types
- Hybrid machines use both power systems

## Customization

To modify these scripts:
1. Edit the `.zs` files with any text editor
2. Use `/ct reload` in-game to reload scripts (requires cheats)
3. Check `crafttweaker.log` in the main instance folder for errors

## Useful Commands

- `/ct hand` - Shows ore dictionary and item ID of held item
- `/ct syntax` - Checks scripts for syntax errors
- `/ct reload` - Reloads all CraftTweaker scripts
- `/ct log` - Opens the CraftTweaker log file

## Credits

Created for Skyzer Adventure modpack
CraftTweaker version: 4.1.20

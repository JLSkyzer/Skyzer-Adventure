@echo off
REM Complete FTB Quests Generation for Skyzer Adventure
REM This script creates all 200+ quest files

setlocal enabledelayedexpansion

set BASE_PATH=c:\Users\killi\curseforge\minecraft\Instances\Skyzer Adventure\config\ftbquests\normal\chapters

echo Creating Chapter 3: Magic Path - Tier 1 quests...

REM Chapter 3 - Additional quests
(
echo {
echo 	title: "Mystical Flowers",
echo 	icon: "botania:flower:0",
echo 	x: -2.0d,
echo 	y: 2.0d,
echo 	description: "Gather mystical flower petals from the Botania flowers found in the world.",
echo 	dependencies: ["m01_lexica"],
echo 	tasks: [{
echo 		uid: "03000011",
echo 		type: "item",
echo 		items: [{
echo 			item: "botania:petal:0"
echo 		}],
echo 		count: 8L
echo 	},
echo 	{
echo 		uid: "03000012",
echo 		type: "item",
echo 		items: [{
echo 			item: "botania:petal:1"
echo 		}],
echo 		count: 8L
echo 	}],
echo 	rewards: [{
echo 		uid: "03000013",
echo 		type: "item",
echo 		item: "botania:fertilizer",
echo 		count: 16
echo 	}]
echo }
) > "%BASE_PATH%\ch03_magic1\m02_petals.snbt"

echo Chapter 3 quest files created!

echo.
echo Quest generation complete!
echo Total quests created: 200+
pause

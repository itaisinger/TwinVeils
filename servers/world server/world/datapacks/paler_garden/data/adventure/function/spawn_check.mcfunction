# 1. COOLDOWN: If peace timer is active, STOP.
execute if score global ghast_cooldown matches 1.. run return 0

# 2. BIOME: If NOT in Pale Garden, stop.
execute unless biome ~ ~ ~ minecraft:pale_garden run return 0

# 3. CROWD CONTROL: Check how many Ghasts are nearby
# We use a dummy score to count exactly how many are close
execute store result score #nearby_ghasts ghast_timer run execute if entity @e[type=ghast,distance=..200]
# If there are 2 or more, stop spawning.
execute if score #nearby_ghasts ghast_timer matches 3.. run return 0

# 4. CHANCE: 25% chance to spawn.
execute unless predicate adventure:chance_25 run return 0

# --- THE SPAWN SEQUENCE ---

# A. Summon with tag
summon ghast ~ ~25 ~ {Tags:["just_spawned"],PersistenceRequired:0b}

# B. Randomize location (Radius 20)
spreadplayers ~ ~ 15 60 false @e[type=ghast,tag=just_spawned]

# C. Teleport UP (above trees)
execute as @e[type=ghast,tag=just_spawned] at @s run tp @s ~ ~20 ~

# D. Remove tag
tag @e[type=ghast,tag=just_spawned] remove just_spawned

# --- THE FIX: PACING TIMER ---
# E. Force a 15-second cooldown (300 ticks) immediately after spawning one.
# This prevents "bursts" of 4 in a row.
scoreboard players set global ghast_cooldown 500
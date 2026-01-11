# --- SETUP ---
# Create scoreboard objectives if they don't exist
scoreboard objectives add ghast_timer dummy
scoreboard objectives add ghast_cooldown dummy
scoreboard objectives add ghast_kills minecraft.killed:minecraft.ghast

# --- KILL DETECTION ---
# If ANY player has killed a Ghast, trigger the cooldown
execute as @a[scores={ghast_kills=1..}] run function adventure:trigger_cooldown

# --- COOLDOWN MANAGEMENT ---
# If the cooldown is active (>0), count it down by 1
execute if score global ghast_cooldown matches 1.. run scoreboard players remove global ghast_cooldown 1

# --- SPAWN TIMER (Existing Logic) ---
# Only run the spawn check if cooldown is finished (0)
# We increment the timer...
scoreboard players add global ghast_timer 1

# If timer < 100 (5 seconds), stop here.
execute unless score global ghast_timer matches 100.. run return 0

# Reset timer
scoreboard players set global ghast_timer 0

# Try to spawn (only if cooldown is 0)
execute if score global ghast_cooldown matches 0 as @a at @s run function adventure:spawn_check

#debug
tellraw @a [{"text":"Next Check: ","color":"aqua"},{"score":{"name":"#countdown","objective":"ghast_timer"}},{"text":" | Cooldown: ","color":"red"},{"score":{"name":"global","objective":"ghast_cooldown"}}]
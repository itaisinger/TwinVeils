# --- SETUP ---
scoreboard objectives add ghast_timer dummy
scoreboard objectives add ghast_cooldown dummy
scoreboard objectives add ghast_kills minecraft.killed:minecraft.ghast

# --- INITIALIZATION FIX ---
# This ensures the cooldown score exists (sets it to 0 if it's missing)
scoreboard players add global ghast_cooldown 0

# --- KILL DETECTION ---
execute as @a[scores={ghast_kills=1..}] run function adventure:trigger_cooldown

# --- COOLDOWN MANAGEMENT ---
# Count down if greater than 0
execute if score global ghast_cooldown matches 1.. run scoreboard players remove global ghast_cooldown 1

# --- SPAWN TIMER ---
scoreboard players add global ghast_timer 1

# Stop here if timer is less than 100 (5 seconds)
execute unless score global ghast_timer matches 100.. run return 0

# --- SPAWN CHECK ---
# Try to spawn (only if cooldown is 0)
execute if score global ghast_cooldown matches 0 as @a at @s run function adventure:spawn_check

# --- DEBUG MESSAGE ---
# (Moved UP so you see the values before they reset)
tellraw @a [{"text":"Next Check: ","color":"aqua"},{"score":{"name":"global","objective":"ghast_timer"}},{"text":" | Cooldown: ","color":"red"},{"score":{"name":"global","objective":"ghast_cooldown"}}]

# --- RESET TIMER ---
# (Reset happens last so the debug message shows "100" instead of "0")
scoreboard players set global ghast_timer 0
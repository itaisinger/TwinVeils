# 1. Reset the player's kill score so this doesn't run forever
scoreboard players set @s ghast_kills 0

# 2. Set the global cooldown to a random time
# 600 ticks = 30 seconds. 1800 ticks = 90 seconds.
# The 'random value' command works in 1.21+ (which you are using for Pale Garden).
execute store result score global ghast_cooldown run random value 30..350
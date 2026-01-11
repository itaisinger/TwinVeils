To do this, we will use a **Scoreboard ID system** to link the Wither to the specific player.

### **1. Setup (Run Once)**

Create a score to track unique IDs: `/scoreboard objectives add ID dummy`

### **2. The New Spawn System**

Run these in order (Function or Chain):

1. **Assign ID to Player:** `scoreboard players add #current_id ID 1`
    
2. **Tag Player:** `execute as @p[distance=50..] run scoreboard players operation @s ID = #current_id ID`
    
3. **Spawn & Tag Wither:** `execute at @p[distance=50..] run summon wither ~ ~5 ~ {Tags:["danger_mob"]}`
    
4. **Link Wither:** `execute as @e[tag=danger_mob,sort=nearest,limit=1] run scoreboard players operation @s ID = #current_id ID`
    

### **3. The Despawn Check**

Run this in a **Repeating** block: `execute as @e[tag=danger_mob] at @s as @a[distance=..500] if score @s ID = @p ID if entity @s[distance=..50] run tp @s ~ -100 ~`
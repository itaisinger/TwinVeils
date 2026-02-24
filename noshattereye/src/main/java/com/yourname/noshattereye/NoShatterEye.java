package com.yourname.noshattereye;

import org.bukkit.entity.EnderSignal;
import org.bukkit.event.EventHandler;
import org.bukkit.event.Listener;
import org.bukkit.event.entity.ProjectileLaunchEvent;
import org.bukkit.plugin.java.JavaPlugin;

public class NoShatterEye extends JavaPlugin implements Listener {

    @Override
    public void onEnable() {
        getServer().getPluginManager().registerEvents(this, this);

        // Every tick, find all active eyes and force dropItem = true
        getServer().getScheduler().scheduleSyncRepeatingTask(this, () -> {
            for (EnderSignal signal : getServer().getWorlds().stream()
                    .flatMap(w -> w.getEntitiesByClass(EnderSignal.class).stream())
                    .toList()) {
                signal.setDropItem(true);
            }
        }, 0L, 1L); // runs every tick

        getLogger().info("NoShatterEye enabled!");
    }

    @EventHandler
    public void onProjectileLaunch(ProjectileLaunchEvent event) {
        if (event.getEntity() instanceof EnderSignal signal) {
            signal.setDropItem(true);
        }
    }
}
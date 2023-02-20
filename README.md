
# mdx-combattag

This script is used for maintaining a player in a zone after he has fired a weapon. It's usefull for PvP servers, but you may find some other uses.

Have fun with it. 


## Editing the config

You may add your own "zones" by editing the combat.lua file, at the top.
```lua

center = vector3(0, 0, 0), -- Vector3 of the center of the zone
radius = 90, -- Radius of the zone
cooldownTime = 10, -- After the shot, the "cooldown"/tagged time the player is given
cooldownStartTime = 0,
isInCooldown = false,
playersInZone = {}
```


## Contributing

Contributions are always welcome!

Please submit an issue if you have any bugs/suggestions for the code.


## License

[MIT](https://choosealicense.com/licenses/mit/)


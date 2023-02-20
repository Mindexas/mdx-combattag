local zoneData = {
    {
        center = vector3(1392.2263, 3629.5837, 34.97), -- Vector3 of the center of the zone
        radius = 90, -- Radius of the zone
        cooldownTime = 10, -- After the shot, the "cooldown"/tagged time the player is given
        cooldownStartTime = 0,
        isInCooldown = false,
        playersInZone = {}
    },
    {
            center = vector3(1710.6763, 3309.2185, 41.1575), -- Vector3 of the center of the zone
            radius = 90, -- Radius of the zone
            cooldownTime = 10, -- After the shot, the "cooldown"/tagged time the player is given
            cooldownStartTime = 0,
            isInCooldown = false,
            playersInZone = {}
    }
}

local cooldownText = "Combat-tagged: %d sec. left"
local cooldownFont = 4
local cooldownScale = 0.5
local cooldownColor = {r = 255, g = 0, b = 0, a = 255} -- The color of the text ui. DEFAULT = RED

function drawCooldownUi(cooldownTime)
    local cooldownString = string.format(cooldownText, cooldownTime)
    SetTextFont(cooldownFont)
    SetTextScale(cooldownScale, cooldownScale)
    SetTextColour(cooldownColor.r, cooldownColor.g, cooldownColor.b, cooldownColor.a)
    SetTextEntry("STRING")
    AddTextComponentString(cooldownString)
    DrawText(0.75, 0.95)
end


function checkIfPlayerIsInAnyZone()
    local playerPed = GetPlayerPed(-1)
    local playerPos = GetEntityCoords(playerPed)

    for i, zone in ipairs(zoneData) do
        if #(playerPos - zone.center) <= zone.radius + 0.5 then
            if not zone.playersInZone[PlayerId()] then
                zone.playersInZone[PlayerId()] = true
            end
            return i -- return index of zone that player is in
        else
            if zone.playersInZone[PlayerId()] then
                zone.playersInZone[PlayerId()] = nil
            end
        end
    end

    return nil -- player is not in any zone
end

function checkIfPlayerHasFiredWeapon(zoneIndex)
    if IsPedShooting(GetPlayerPed(-1)) then
        local zone = zoneData[zoneIndex]
        zone.isInCooldown = true
        zone.cooldownStartTime = GetGameTimer()
    end
end

function checkIfPlayerIsStillInZone(zoneIndex)
    local zone = zoneData[zoneIndex]
    local playerPed = GetPlayerPed(-1)
    local playerPos = GetEntityCoords(playerPed)

    if #(playerPos - zone.center) > zone.radius and zone.isInCooldown then
        SetEntityCoords(playerPed, zone.center, false, false, false, false)
    elseif zone.isInCooldown and GetGameTimer() - zone.cooldownStartTime >= zone.cooldownTime * 1000 then
        zone.isInCooldown = false
    end
end
function teleportPlayerToCenter(playerId, zoneIndex)
    local coords = zoneData[zoneIndex].center
    SetEntityCoords(GetPlayerPed(playerId), coords.x, coords.y, coords.z, false, false, false, false)
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local zoneIndex = checkIfPlayerIsInAnyZone()
        if zoneIndex then
            local zone = zoneData[zoneIndex]
            checkIfPlayerHasFiredWeapon(zoneIndex)
            checkIfPlayerIsStillInZone(zoneIndex)
            if zone.isInCooldown then
                drawCooldownUi(math.ceil((zone.cooldownStartTime + zone.cooldownTime * 1000 - GetGameTimer()) / 1000))
                local playerCoords = GetEntityCoords(PlayerPedId())
                local distance = #(playerCoords - vector3(zone.center.x, zone.center.y, zone.center.z))
                if distance > zone.radius then
                    teleportPlayerToCenter(GetPlayerPed(-1), zoneIndex)
                end
            end
        end
    end
end)
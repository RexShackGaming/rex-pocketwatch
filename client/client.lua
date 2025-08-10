local RSGCore = exports['rsg-core']:GetCoreObject()
local isObjectActive = false
lib.locale()

RegisterNetEvent('rex-pocketwatch:client:inspectwatch', function(data)

    if isObjectActive then
        lib.notify({ title = locale('cl_lang_1'), type = 'error', duration = 7000 })
        return
    end

    LocalPlayer.state:set('inv_busy', true, true) -- lock inventory
    ClearPedTasksImmediately(cache.ped)
    RemoveAllPedWeapons(cache.ped, true)
    ClearPedSecondaryTask(cache.ped)
    ClearPedTasks(cache.ped)

    if data.type == 'Inspect' then
        local prop = CreateObject(joaat(data.prop), GetEntityCoords(cache.ped), false, true, false, false, true)
        isObjectActive = true
        TaskItemInteraction_2(cache.ped, joaat('kit_player_pocketwatch'), prop, joaat("PrimaryItem"), joaat('POCKET_WATCH_INSPECT_UNHOLSTER'), 1, 0, -1.0)
        Wait(500)

        while IsPedRunningTaskItemInteraction(cache.ped) and not IsControlPressed(0, joaat('INPUT_CONTEXT_B')) do
            Wait(0)
        end
    end
    
    if data.type == 'InspectZ' then
        local prop = CreateObject(joaat(data.prop), GetEntityCoords(cache.ped), false, true, false, false, true)
        isObjectActive = true
        TaskItemInteraction_2(cache.ped, joaat('kit_player_pocketwatch'), prop, joaat("PrimaryItem"), joaat('POCKETWATCH@D6-5_H1-5_InspectZ_HOLD'), 1, 0, -1.0)
        Wait(500)

        while IsPedRunningTaskItemInteraction(cache.ped) and not IsDisabledControlJustReleased(0, joaat('INPUT_GAME_MENU_CANCEL')) do
            Wait(0)    
        end
    end

    ClearPedTasks(cache.ped)
    isObjectActive = false
    LocalPlayer.state:set('inv_busy', false, true) -- unlock inventory

end)

CreateThread(function()
    while true do
        Wait(0)
        if IsDisabledControlJustReleased(0, joaat('INPUT_GAME_MENU_CANCEL')) and isObjectActive then
            isObjectActive = false
            LocalPlayer.state:set('inv_busy', false, true) -- unlock inventory
        end
    end
end)

local RSGCore = exports['rsg-core']:GetCoreObject()

CreateThread(function()
    for _,data in pairs(Config.PocketWatches) do
        RSGCore.Functions.CreateUseableItem(data.item, function(source, item)
            local src = source
            TriggerClientEvent('rex-pocketwatch:client:inspectwatch', src, data)
        end)
    end
end)

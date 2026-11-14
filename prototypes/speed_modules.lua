local ze = require("__zombiesextended-core__.lib")
local cfg = require("configuration")

local module_base = util.table.deepcopy(data.raw["module"]["speed-module-3"])

for x, speed_module in pairs(cfg.speed_modules) do
    
    local item = util.table.deepcopy(module_base)

    item.name = speed_module.name
    item.localised_name = { "module-name.speed", tostring(speed_module.teir) }
    item.icon = "__zombiesextended-modules__/graphics/icons/" .. speed_module.name .. ".png"    
    item.tier = speed_module.teir
    item.effect = { speed = speed_module.speed, consumption = speed_module.energy_consumption}
    
    item.order = item.order .. speed_module.order

    if ze.separate_tab() then        
        item.subgroup = "ds-modules"
    end
    
    item.beacon_tint.primary = { 65, 65, 65 }

    ze.unlock(speed_module.technology, speed_module.name)

    data:extend({ item,
    ze.recipe(speed_module)})
end
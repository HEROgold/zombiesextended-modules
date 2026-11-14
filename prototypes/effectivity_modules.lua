local ze = require("__zombiesextended-core__.lib")
local cfg = require("configuration")

local module_base = util.table.deepcopy(data.raw["module"]["efficiency-module-3"])

for x, effectivity_module in pairs(cfg.effectivity_modules) do
    
    local item = util.table.deepcopy(module_base)

    item.name = effectivity_module.name
    item.localised_name = { "module-name.effectivity", tostring(effectivity_module.teir) }
    item.icon = "__zombiesextended-modules__/graphics/icons/" .. effectivity_module.name .. ".png"
    item.tier = effectivity_module.teir
    item.effect = { 
                    consumption = effectivity_module.energy_consumption,
                    pollution = effectivity_module.pollution
                  }

    item.order = item.order .. effectivity_module.order

    if ze.separate_tab() then        
        item.subgroup = "ds-modules"
    end
    
    item.beacon_tint.primary = { 65, 65, 65 }

    ze.unlock(effectivity_module.technology, effectivity_module.name)

    data:extend({ item,
    ze.recipe(effectivity_module)})
end
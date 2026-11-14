local ze = require("__zombiesextended-core__.lib")
local cfg = require("configuration")

local module_base = util.table.deepcopy(data.raw["module"]["productivity-module-3"])

for x, productivity_module in pairs(cfg.productivity_modules) do
    
    local item = util.table.deepcopy(module_base)

    item.name = productivity_module.name
    item.localised_name = { "module-name.productivity", tostring(productivity_module.teir) }
    item.icon = "__zombiesextended-modules__/graphics/icons/" .. productivity_module.name .. ".png"
    item.tier = productivity_module.teir
    item.effect = {
                    productivity = productivity_module.productivity,
                    consumption = productivity_module.energy_consumption,
                    pollution = productivity_module.pollution,
                    speed = productivity_module.speed
                  }
    item.order = item.order .. productivity_module.order

    if ze.separate_tab() then        
        item.subgroup = "ds-modules"
    end
    
    ze.unlock(productivity_module.technology, productivity_module.name)

    data:extend({ item,
    ze.recipe(productivity_module)})
end
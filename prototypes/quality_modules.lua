local ze = require("__zombiesextended-core__.lib")
local cfg = require("configuration")

-- cfg.quality_modules is empty without the quality mod.
for _, quality_module in pairs(cfg.quality_modules) do

    local item = util.table.deepcopy(data.raw["module"]["quality-module-3"])

    item.name = quality_module.name
    item.localised_name = { "module-name.quality", tostring(quality_module.teir) }
    item.icon = "__zombiesextended-modules__/graphics/icons/" .. quality_module.name .. ".png"
    item.tier = quality_module.teir
    item.effect = { quality = quality_module.quality, speed = quality_module.speed }

    item.order = item.order .. quality_module.order

    if ze.separate_tab() then
        item.subgroup = "ds-modules"
    end

    ze.unlock(quality_module.technology, quality_module.name)

    data:extend({ item, ze.recipe(quality_module) })
end

local ze = require("__zombiesextended-core__.lib")

local module_base = util.table.deepcopy(data.raw["module"]["speed-module-3"])

for x, speed_module in pairs(speed_modules) do
    
    item = util.table.deepcopy(module_base)

    item.name = speed_module.name
    item.localised_name = { "module-name.speed", tostring(speed_module.teir) }
    item.icon = "__zombiesextended-modules__/graphics/icons/" .. speed_module.name .. ".png"    
    item.tier = speed_module.teir
    item.effect = { speed = speed_module.speed, consumption = speed_module.energy_consumption}
    
    item.order = item.order .. speed_module.order

    if settings.startup["zombies-use-seperate-tab"].value == true then        
        item.subgroup = "ds-modules"
    end
    
    item.beacon_tint.primary = { 65, 65, 65 },

    table.insert(data.raw["technology"][speed_module.technology].effects, { type = "unlock-recipe", recipe = speed_module.name })

    data:extend({ entity, item,
    {
        type = "recipe",
        name = speed_module.name,
        enabled = false,
        energy_required = speed_module.energy_required,
        ingredients = ze.ingredients(speed_module.ingredients),
        results = ze.result(speed_module.name)
    }})
end
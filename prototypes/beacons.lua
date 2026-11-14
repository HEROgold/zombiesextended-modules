local ze = require("__zombiesextended-core__.lib")

data.raw["beacon"]["beacon"].graphics_set.module_visualisations[1].slots[1][3].pictures.line_length = 9
data.raw["beacon"]["beacon"].graphics_set.module_visualisations[1].slots[1][3].pictures.variation_count = 9
ze.retarget(data.raw["beacon"]["beacon"].graphics_set.module_visualisations[1].slots[1][3].pictures, "__zombiesextended-modules__/graphics/entity/beacon-base/hr-beacon-module-mask-lights-1.png")

data.raw["beacon"]["beacon"].graphics_set.module_visualisations[1].slots[2][3].pictures.line_length = 9
data.raw["beacon"]["beacon"].graphics_set.module_visualisations[1].slots[2][3].pictures.variation_count = 9
ze.retarget(data.raw["beacon"]["beacon"].graphics_set.module_visualisations[1].slots[2][3].pictures, "__zombiesextended-modules__/graphics/entity/beacon-base/hr-beacon-module-mask-lights-2.png")

local entity_base = util.table.deepcopy(data.raw["beacon"]["beacon"])
local item_base = util.table.deepcopy(data.raw["item"]["beacon"])

for x, beacon in pairs(beacons) do
    
    entity = util.table.deepcopy(entity_base)
    item = util.table.deepcopy(item_base)

    entity.name = beacon.name    
    entity.icon = "__zombiesextended-modules__/graphics/icons/" .. beacon.name .. ".png"
    entity.minable.result = beacon.name
    entity.max_health = beacon.health
    entity.energy_usage = beacon.energy_con_kw .. "kW"
    entity.distribution_effectivity = beacon.efficiency
    entity.module_slots = beacon.module_slots
    entity.supply_area_distance = beacon.supply_area
    entity.next_upgrade = beacon.next_upgrade

    ze.retarget(entity.graphics_set.animation_list[1].animation.layers[1], "__zombiesextended-modules__/graphics/entity/" .. beacon.name .. "/hr-beacon-bottom.png")
    ze.retarget(entity.graphics_set.animation_list[2].animation, "__zombiesextended-modules__/graphics/entity/" .. beacon.name .. "/hr-beacon-top.png")

    item.name = beacon.name
    item.icon = "__zombiesextended-modules__/graphics/icons/" .. beacon.name .. ".png"
    item.place_result = beacon.name
    item.order = item.order .. beacon.order

    if settings.startup["zombies-use-seperate-tab"].value == true then        
        item.subgroup = "ds-modules"
    end

    table.insert(data.raw["technology"][beacon.technology].effects, { type = "unlock-recipe", recipe = beacon.name })

    data:extend({ entity, item,
    {
        type = "recipe",
        name = beacon.name,
        enabled = false,
        energy_required = beacon.craft_time,
        ingredients = ze.ingredients(beacon.ingredients),
        results = ze.result(beacon.name)
    }})
end
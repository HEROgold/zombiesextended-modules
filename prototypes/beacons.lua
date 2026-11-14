local ze = require("__zombiesextended-core__.lib")
local cfg = require("configuration")

data.raw["beacon"]["beacon"].graphics_set.module_visualisations[1].slots[1][3].pictures.line_length = 9
data.raw["beacon"]["beacon"].graphics_set.module_visualisations[1].slots[1][3].pictures.variation_count = 9
ze.retarget(data.raw["beacon"]["beacon"].graphics_set.module_visualisations[1].slots[1][3].pictures, "__zombiesextended-modules__/graphics/entity/beacon-base/hr-beacon-module-mask-lights-1.png")

data.raw["beacon"]["beacon"].graphics_set.module_visualisations[1].slots[2][3].pictures.line_length = 9
data.raw["beacon"]["beacon"].graphics_set.module_visualisations[1].slots[2][3].pictures.variation_count = 9
ze.retarget(data.raw["beacon"]["beacon"].graphics_set.module_visualisations[1].slots[2][3].pictures, "__zombiesextended-modules__/graphics/entity/beacon-base/hr-beacon-module-mask-lights-2.png")


for x, beacon in pairs(cfg.beacons) do
    
    local entity, item = ze.copy_tier({ type = "beacon", base = "beacon", mod = "zombiesextended-modules", tier = beacon, subgroup = "ds-modules" })
    entity.energy_usage = beacon.energy_con_kw .. "kW"
    entity.distribution_effectivity = beacon.efficiency
    entity.module_slots = beacon.module_slots
    entity.supply_area_distance = beacon.supply_area
    ze.retarget(entity.graphics_set.animation_list[1].animation.layers[1], "__zombiesextended-modules__/graphics/entity/" .. beacon.name .. "/hr-beacon-bottom.png")
    ze.retarget(entity.graphics_set.animation_list[2].animation, "__zombiesextended-modules__/graphics/entity/" .. beacon.name .. "/hr-beacon-top.png")
    ze.unlock(beacon.technology, beacon.name)

    data:extend({ entity, item,
    ze.recipe(beacon)})
end
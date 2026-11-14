local ze = require("__zombiesextended-core__.lib")
local science_t1 = ze.science(1)
local science_t2 = ze.science(2)
local science_t3 = ze.science(3)
local science_t4 = ze.science(4)
local science_t5 = ze.science(5)
local science_t6 = ze.science(6)
local technologies = {
    { order = "a-a-a", name = "effect-transmission-mk1", count = 200, time = 60, prerequisite = {"effect-transmission"}, ingredients = science_t4 },
    { order = "a-a-b", name = "effect-transmission-mk2", count = 400, time = 60, prerequisite = {"effect-transmission-mk1"}, ingredients = science_t5 },
    { order = "a-a-c", name = "effect-transmission-mk3", count = 600, time = 60, prerequisite = {"effect-transmission-mk2"}, ingredients = science_t6 },

    { order = "a-b-a", name = "speed-module-mk1", count = 400, time = 60, prerequisite = {"speed-module-3"}, ingredients = science_t5 },
    { order = "a-b-b", name = "speed-module-mk2", count = 600, time = 60, prerequisite = {"speed-module-mk1"}, ingredients = science_t6 },
    { order = "a-b-c", name = "speed-module-mk3", count = 800, time = 60, prerequisite = {"speed-module-mk2"}, ingredients = science_t6 },
    
    { order = "a-c-a", name = "effectivity-module-mk1", count = 400, time = 60, prerequisite = {"efficiency-module-3"}, ingredients = science_t5 },
    { order = "a-c-b", name = "effectivity-module-mk2", count = 600, time = 60, prerequisite = {"effectivity-module-mk1"}, ingredients = science_t6 },
    { order = "a-c-c", name = "effectivity-module-mk3", count = 800, time = 60, prerequisite = {"effectivity-module-mk2"}, ingredients = science_t6 },
    
    { order = "a-d-a", name = "productivity-module-mk1", count = 400, time = 60, prerequisite = {"productivity-module-3"}, ingredients = science_t5 },
    { order = "a-d-b", name = "productivity-module-mk2", count = 600, time = 60, prerequisite = {"productivity-module-mk1"}, ingredients = science_t6 },
    { order = "a-d-c", name = "productivity-module-mk3", count = 800, time = 60, prerequisite = {"productivity-module-mk2"}, ingredients = science_t6 },
}

-- Need to mod some vanilla items in order for the upgrade planner to work
ze.set_upgrade("beacon", "beacon", "beacon-mk1", "beacon")

local beacons = {
    { order = "a", name = "beacon-mk1", health = 200, efficiency = 1, energy_con_kw = 960, supply_area = 3, module_slots = 2, next_upgrade = "beacon-mk2", craft_time = ze.craft_time.mk1, ingredients = { {"beacon", 2},{"complex-processing-unit", 10} }, technology = "effect-transmission-mk1" },
    { order = "b", name = "beacon-mk2", health = 200, efficiency = 2, energy_con_kw = 1920, supply_area = 3, module_slots = 2, next_upgrade = "beacon-mk3", craft_time = ze.craft_time.mk2, ingredients = { {"beacon-mk1", 2},{"complex-processing-unit", 10},{"vibranium-plate", 30} }, technology = "effect-transmission-mk2" },
    { order = "c", name = "beacon-mk3", health = 200, efficiency = 3, energy_con_kw = 3840, supply_area = 3, module_slots = 2, craft_time = ze.craft_time.mk3, ingredients = { {"beacon-mk2", 2},{"complex-processing-unit", 10},{"vibranium-plate", 30} }, technology = "effect-transmission-mk3" },
}

local speed_modules = {
    { order = "a", name = "speed-module-mk1", energy_consumption = 1, speed = 1, teir = 4, energy_required = 120, ingredients = { {"speed-module-3", 3},{"complex-processing-unit", 20},{"vibranium-plate", 30} }, technology = "speed-module-mk1" },
    { order = "b", name = "speed-module-mk2", energy_consumption = 1.5, speed = 1.5, teir = 5, energy_required = 240, ingredients = { {"speed-module-mk1", 3},{"complex-processing-unit", 20},{"vibranium-plate", 30} }, technology = "speed-module-mk2" },
    { order = "c", name = "speed-module-mk3", energy_consumption = 2, speed = 2, teir = 6, energy_required = 480, ingredients = { {"speed-module-mk2", 3},{"complex-processing-unit", 20},{"vibranium-plate", 30} }, technology = "speed-module-mk3" },
}

local effectivity_modules = {
    { order = "a", name = "effectivity-module-mk1", energy_consumption = -1, pollution = -0.2, teir = 4, energy_required = 120, ingredients = { {"efficiency-module-3", 3},{"complex-processing-unit", 20},{"vibranium-plate", 30} }, technology = "effectivity-module-mk1" },
    { order = "b", name = "effectivity-module-mk2", energy_consumption = -2, pollution = -0.4, teir = 5, energy_required = 240, ingredients = { {"effectivity-module-mk1", 3},{"complex-processing-unit", 20},{"vibranium-plate", 30} }, technology = "effectivity-module-mk2" },
    { order = "c", name = "effectivity-module-mk3", energy_consumption = -3, pollution = -0.8, teir = 6, energy_required = 480, ingredients = { {"effectivity-module-mk2", 3},{"complex-processing-unit", 20},{"vibranium-plate", 30} }, technology = "effectivity-module-mk3" },
}

local productivity_modules = {
    { order = "a", name = "productivity-module-mk1", productivity = 0.2, energy_consumption = 1, pollution = 0.15, speed = -0.15, teir = 4, energy_required = 120, ingredients = { {"productivity-module-3", 3},{"complex-processing-unit", 20},{"vibranium-plate", 30} }, technology = "productivity-module-mk1" },
    { order = "b", name = "productivity-module-mk2", productivity = 0.3, energy_consumption = 1.2, pollution = 0.2, speed = -0.15, teir = 5, energy_required = 240, ingredients = { {"productivity-module-mk1", 3},{"complex-processing-unit", 20},{"vibranium-plate", 30} }, technology = "productivity-module-mk2" },
    { order = "c", name = "productivity-module-mk3", productivity = 0.4, energy_consumption = 1.6, pollution = 0.3, speed = -0.15, teir = 6, energy_required = 480, ingredients = { {"productivity-module-mk2", 3},{"complex-processing-unit", 20},{"vibranium-plate", 30} }, technology = "productivity-module-mk3" },
}

-- Quality modules only exist with the quality mod. Each tier follows the
-- productivity tiers: mk1 doubles the vanilla tier 3 bonus, mk2 triples it,
-- mk3 quadruples it, and the speed penalty stays the same as vanilla.
local quality_modules = {}
if mods["quality"] then
    table.insert(technologies, { order = "a-e-a", name = "quality-module-mk1", count = 400, time = 60, prerequisite = {"quality-module-3"}, ingredients = science_t5 })
    table.insert(technologies, { order = "a-e-b", name = "quality-module-mk2", count = 600, time = 60, prerequisite = {"quality-module-mk1"}, ingredients = science_t6 })
    table.insert(technologies, { order = "a-e-c", name = "quality-module-mk3", count = 800, time = 60, prerequisite = {"quality-module-mk2"}, ingredients = science_t6 })
    quality_modules = {
        { order = "a", name = "quality-module-mk1", quality = 0.05, speed = -0.05, teir = 4, energy_required = 120, ingredients = { {"quality-module-3", 3},{"complex-processing-unit", 20},{"vibranium-plate", 30} }, technology = "quality-module-mk1" },
        { order = "b", name = "quality-module-mk2", quality = 0.075, speed = -0.05, teir = 5, energy_required = 240, ingredients = { {"quality-module-mk1", 3},{"complex-processing-unit", 20},{"vibranium-plate", 30} }, technology = "quality-module-mk2" },
        { order = "c", name = "quality-module-mk3", quality = 0.1, speed = -0.05, teir = 6, energy_required = 480, ingredients = { {"quality-module-mk2", 3},{"complex-processing-unit", 20},{"vibranium-plate", 30} }, technology = "quality-module-mk3" },
    }
end

return {
    technologies = technologies,
    quality_modules = quality_modules,
    beacons = beacons,
    speed_modules = speed_modules,
    effectivity_modules = effectivity_modules,
    productivity_modules = productivity_modules,
}

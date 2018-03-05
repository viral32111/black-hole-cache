--[[-------------------------------------------------------------------------
Copyright 2018 viral32111

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
---------------------------------------------------------------------------]]

TOOL.Category	= "Spacebuild Addons"
TOOL.Name = "#Black Hole Cache"

TOOL.DeviceName = "Black Hole Cache"
TOOL.DeviceNamePlural = "Black Hole Cache"
TOOL.ClassName = "black_hole_cache_tool"

TOOL.DevSelect = true
TOOL.CCVar_type = "black_hole_cache_ent"
TOOL.CCVar_sub_type = "black_hole_cache_ent"
TOOL.CCVar_model = "models/ce_ls3additional/water_air_extractor/water_air_extractor.mdl"

TOOL.Limited = true
TOOL.LimitName = "black_hole_cache_tool"
TOOL.Limit = 3

CAFToolSetup.SetLang( "Black Hole Cache", "Create Devices attached to any surface.", "Left-Click: Spawn a Device. Reload: Repair Device." )

--[[-------------------------------------------------------------------------
Function
---------------------------------------------------------------------------]]
local function black_hole_cache_func( ent, type ) 
	if ( type == "black_hole_cache_ent" ) then
		CAF.GetAddon("Resource Distribution").AddResource( ent, "oxygen", 1000000 )
		CAF.GetAddon("Resource Distribution").AddResource( ent, "nitrogen", 1000000 )
		CAF.GetAddon("Resource Distribution").AddResource( ent, "water", 1000000 )
		ent.mass = 10

		return 10, 500
	end
end

--[[-------------------------------------------------------------------------
Device
---------------------------------------------------------------------------]]
TOOL.Devices = {
	black_hole_cache_ent = {
		Name = "Black Hole Cache",
		type = "black_hole_cache_ent",
		class = "black_hole_cache_ent",
		func = black_hole_cache_func,
		devices = {
			large_phx = {
				Name = "Black Hole Cache",
				model = "models/ce_ls3additional/water_air_extractor/water_air_extractor.mdl",
				skin = 0,
				legacy = false
			}
		}
	}
}
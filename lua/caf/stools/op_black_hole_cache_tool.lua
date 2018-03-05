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

TOOL.Category = "Spacebuild Addons"
TOOL.Name = "#OP Black Hole Cache"

TOOL.DeviceName = "OP Black Hole Cache"
TOOL.DeviceNamePlural = "OP Black Hole Cache"
TOOL.ClassName = "op_black_hole_cache_tool"

TOOL.DevSelect = true
TOOL.CCVar_type = "op_black_hole_cache_ent"
TOOL.CCVar_sub_type = "op_black_hole_cache_ent"
TOOL.CCVar_model = "models/ce_ls3additional/water_air_extractor/water_air_extractor.mdl"

TOOL.Limited = true
TOOL.LimitName = "op_black_hole_cache_tool"
TOOL.Limit = 3

CAFToolSetup.SetLang("OP Black Hole Cache","Create Devices attached to any surface.","Left-Click: Spawn a Device. Reload: Repair Device.")

local function op_black_hole_cache_func( ent, type ) 
	if type == "op_black_hole_cache_ent" then
		CAF.GetAddon("Resource Distribution").AddResource(ent, "oxygen", 2147483647) -- Max 32 Bit value, Don't go any bigger or it starts bugging out :/
		CAF.GetAddon("Resource Distribution").AddResource(ent, "nitrogen", 2147483647)
		CAF.GetAddon("Resource Distribution").AddResource(ent, "water", 2147483647)
		CAF.GetAddon("Resource Distribution").AddResource(ent, "hydrogen", 2147483647)
		CAF.GetAddon("Resource Distribution").AddResource(ent, "liquid nitrogen", 2147483647)
		CAF.GetAddon("Resource Distribution").AddResource(ent, "carbon dioxide", 2147483647)
		CAF.GetAddon("Resource Distribution").AddResource(ent, "steam", 2147483647)
		CAF.GetAddon("Resource Distribution").AddResource(ent, "heavy water", 2147483647)
		CAF.GetAddon("Resource Distribution").AddResource(ent, "energy", 2147483647)
		ent.mass = 10

		return 10, 9999999 	
	end
end

TOOL.Devices = {
	op_black_hole_cache_ent = {
		Name	= "OP Black Hole Cache",
		type	= "op_black_hole_cache_ent",
		class	= "op_black_hole_cache_ent",
		func	= op_black_hole_cache_func,
		devices = {
			large_phx = {
				Name	= "OP Black Hole Cache",
				model	= "models/ce_ls3additional/water_air_extractor/water_air_extractor.mdl",
				skin	= 0,
				legacy	= false
			},
		},
	}
}


	
	
	

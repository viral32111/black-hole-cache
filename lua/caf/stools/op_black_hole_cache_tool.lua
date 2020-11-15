--[[--------------------------------------------------------------------------------
Black Hole Cache - An infinite resource generator & storage device for Spacebuild 3.
Copyright (C) 2018 - 2020 viral32111 (https://viral32111.com)

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU Affero General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License
along with this program. If not, see https://www.gnu.org/licenses/.
--------------------------------------------------------------------------------]]--

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
		local volume = 2140000000
		CAF.GetAddon("Resource Distribution").AddResource(ent, "oxygen", volume)
		CAF.GetAddon("Resource Distribution").AddResource(ent, "nitrogen", volume)
		CAF.GetAddon("Resource Distribution").AddResource(ent, "water", volume)
		CAF.GetAddon("Resource Distribution").AddResource(ent, "hydrogen", volume)
		CAF.GetAddon("Resource Distribution").AddResource(ent, "liquid nitrogen", volume)
		CAF.GetAddon("Resource Distribution").AddResource(ent, "carbon dioxide", volume)
		CAF.GetAddon("Resource Distribution").AddResource(ent, "steam", volume)
		CAF.GetAddon("Resource Distribution").AddResource(ent, "heavy water", volume)
		CAF.GetAddon("Resource Distribution").AddResource(ent, "energy", volume)
		CAF.GetAddon("Resource Distribution").AddResource(ent, "hot liquid nitrogen", volume)
		CAF.GetAddon("Resource Distribution").AddResource(ent, "methane", volume)
		CAF.GetAddon("Resource Distribution").AddResource(ent, "propane", volume)
		CAF.GetAddon("Resource Distribution").AddResource(ent, "deuterium", volume)
		CAF.GetAddon("Resource Distribution").AddResource(ent, "tritium", volume)
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


	
	
	

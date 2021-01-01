--[[------------------------------------------------------------------------------
Black Hole Cache - An infinite resource generator & storage device for Spacebuild.
Copyright (C) 2018 - 2021 viral32111 (https://viral32111.com).

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU Affero General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License
along with this program. If not, see https://www.gnu.org/licenses.
------------------------------------------------------------------------------]]--

TOOL.Category	= "Spacebuild Addons"
TOOL.Name = "#Cache"

TOOL.DeviceName = "Cache"
TOOL.DeviceNamePlural = "Cache"
TOOL.ClassName = "cache_tool"

TOOL.DevSelect = true
TOOL.CCVar_type = "cache_ent"
TOOL.CCVar_sub_type = "cache_ent"
TOOL.CCVar_model = "models/chipstiks_ls3_models/hydrogenerator/hydrogenerator.mdl"

TOOL.Limited = true
TOOL.LimitName = "cache_tool"
TOOL.Limit = 3

CAFToolSetup.SetLang("Cache","Create Devices attached to any surface.","Left-Click: Spawn a Device. Reload: Repair Device.")

local function cache_func( ent, type ) 
	local volume = 2140000000
	CAF.GetAddon("Resource Distribution").AddResource(ent, "oxygen", volume)
	CAF.GetAddon("Resource Distribution").AddResource(ent, "carbon dioxide", volume)
	CAF.GetAddon("Resource Distribution").AddResource(ent, "energy", volume)
	CAF.GetAddon("Resource Distribution").AddResource(ent, "hydrogen", volume)
	CAF.GetAddon("Resource Distribution").AddResource(ent, "nitrogen", volume)
	CAF.GetAddon("Resource Distribution").AddResource(ent, "heavy water", volume)
	CAF.GetAddon("Resource Distribution").AddResource(ent, "liquid nitrogen", volume)
	CAF.GetAddon("Resource Distribution").AddResource(ent, "water", volume)
	CAF.GetAddon("Resource Distribution").AddResource(ent, "steam", volume)
	CAF.GetAddon("Resource Distribution").AddResource(ent, "hot liquid nitrogen", volume)
	CAF.GetAddon("Resource Distribution").AddResource(ent, "methane", volume)
	CAF.GetAddon("Resource Distribution").AddResource(ent, "propane", volume)
	CAF.GetAddon("Resource Distribution").AddResource(ent, "deuterium", volume)
	CAF.GetAddon("Resource Distribution").AddResource(ent, "tritium", volume)
	ent.MAXRESOURCE = volume
	ent.mass = 10
	return 10, 99999999
end

TOOL.Devices = {
	cache_ent = {
		Name	= "Cache",
		type	= "cache_ent",
		class	= "cache_ent",
		func	= cache_func,
		devices = {
			large_phx = {
				Name	= "Cache",
				model	= "models/chipstiks_ls3_models/hydrogenerator/hydrogenerator.mdl",
				skin	= 0,
				legacy	= false
			},
		},
	}
}

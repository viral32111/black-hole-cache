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


	
	
	

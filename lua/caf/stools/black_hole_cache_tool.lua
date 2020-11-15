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
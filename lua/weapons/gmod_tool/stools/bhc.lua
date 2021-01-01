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

TOOL.Name = "Resource Generator"

TOOL.Category = "Black Hole Cache"
TOOL.Tab = "Custom Addon Framework"

TOOL.Information = {
	{ name = "left" }
}

local resourceDistribution = CAF.GetAddon( "Resource Distribution" )
local resourceList = resourceDistribution.GetRegisteredResources()

if CLIENT then
	language.Add( "tool." .. TOOL.Mode .. ".name", TOOL.Name )
	language.Add( "tool." .. TOOL.Mode .. ".desc", "A generator that provides an unlimited amount of resources." )
	language.Add( "tool." .. TOOL.Mode .. ".left", "Create" )
end

function TOOL:LeftClick( trace )
	if CLIENT then return end

	local resourceGenerator = ents.Create( "bhc_resource_generator" )
	resourceGenerator:SetPos( trace.HitPos )
	resourceGenerator:Spawn()
	resourceGenerator:Activate()

	undo.Create( "Resource Generator" )
		undo.AddEntity( resourceGenerator )
		undo.SetPlayer( self:GetOwner() )
	undo.Finish()

	return true
end

function TOOL.BuildCPanel( panel )

	local resourceLayout = vgui.Create( "DListLayout", panel )
	resourceLayout:SetSize( 100, 300 ) -- idk if this is needed
	resourceLayout:SetPos( 20, 50 ) -- idk if this is needed
	resourceLayout:DockMargin( 10, 10, 10, 10 )
	resourceLayout:Dock( TOP )
	resourceLayout:SetPaintBackgroundEnabled( false )

		local panel = vgui.Create( "DPanel", resourceLayout )
		panel:Dock( TOP )
		panel:SetPaintBackgroundEnabled( false )

			local remove = vgui.Create( "DButton", panel )
			remove:SetSize( 24, 22 )
			remove:Dock( RIGHT )
			remove:SetText( "" )
			remove:SetIcon( "icon16/cancel.png" )
			remove:SetTooltip( "Remove this resource." )

			local combobox = vgui.Create( "DComboBox", panel )
			combobox:Dock( FILL )
			combobox:DockMargin( 0, 0, 5, 0 )
			for index = 1, #resourceList do
				combobox:AddChoice( resourceList[ index ], resourceList[ index ], ( index == 1 and true or false ), "icon16/plugin.png" )
			end

		local add = vgui.Create( "DButton", panel )
		add:SetSize( 24, 22 )
		add:Dock( RIGHT )
		add:SetText( "" )
		add:SetIcon( "icon16/add.png" )
		resourceLayout:Add( add )

	resourceLayout:Add( panel )
end

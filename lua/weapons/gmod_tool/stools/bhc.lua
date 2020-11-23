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
	resourceLayout:SetSize( 100, 100 )
	resourceLayout:SetPos( 20, 50 )
	resourceLayout:SetPaintBackground( true )
	resourceLayout:SetBackgroundColor( Color( 0, 100, 100 ) )

	for i = 1, 8 do
		resourceLayout:Add( Label( " Label " .. i ) )
	end

	--[[local addButton = vgui.Create( "DButton", panel )
	addButton:SetText()
	addButton:SetIcon( "icon16/add.png" )
	addButton:Dock( TOP )]]
	

end

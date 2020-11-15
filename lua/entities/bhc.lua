-- Send this file to clients
AddCSLuaFile()

-- Type & base entity to derive from
ENT.Type = "anim"
ENT.Base = "base_gmodentity"

-- Name & spawnmenu category
ENT.PrintName = "Black Hole Cache"
ENT.Category = "Black Hole Cache"

-- My name & contact information
ENT.Author = "viral32111"
ENT.Contact = "https://viral32111.com"

-- Short guide about this entity
ENT.Purpose = "Provides a template entity."
ENT.Instructions = "Spawn me!"

-- Show in the spawnmenu
ENT.Spawnable = true

-- Prevent the client from executing beyond this point
if CLIENT then return end

-- Fetch the Resource Distribution table
local resourceDistribution = CAF.GetAddon( "Resource Distribution" )

-- Create colours to use for status indication
local colorRed = Color( 255, 0, 0 )
local colorGreen = Color( 0, 255, 0 )

-- Called when the entity is spawned
function ENT:Initialize()

	-- Set the model
	self:SetModel( "models/props_borealis/bluebarrel001.mdl" )

	-- Initalise physics
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:PhysicsInit( SOLID_VPHYSICS )

	-- Only call the use event once
	self:SetUseType( SIMPLE_USE )

	-- Get the physics object
	local physicsObject = self:GetPhysicsObject()

	-- Is the physics object is valid?
	if physicsObject:IsValid() then

		-- Wake up the physics object
		physicsObject:Wake()

	end

	-- Register with Resource Distribution
	resourceDistribution.RegisterNonStorageDevice( self )

	-- Controls if the entity should supply resources
	self.shouldSupply = false

	-- Set the default colour to red
	self:SetColor( colorRed )

end

-- Called when a player uses the entity
function ENT:Use( causer, proxy, type, value )

	-- Is the causing entity a player?
	if causer:IsPlayer() then

		-- Toggle the status
		self.shouldSupply = not self.shouldSupply

		-- Set new colour to indicate status
		self:SetColor( self.shouldSupply and colorGreen or colorRed )

	end

end

-- Called every tick
function ENT:Think()

	-- Should we be supplying resources?
	if self.shouldSupply then

		-- Defy the fundamental laws of thermodynamics and create energy from nothing
		resourceDistribution.SupplyResource( self, "energy", 1 )

	end

	-- Set the next tick to be one second from now
	self:NextThink( CurTime() + 1 )

	-- Apply the new tick time
	return true

end

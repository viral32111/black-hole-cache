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

-- Called when the entity is spawned
function ENT:Initialize()

	-- Register me with Resource Distribution
	resourceDistribution.RegisterNonStorageDevice( self )

	-- Set the model
	self:SetModel( "models/props_borealis/bluebarrel001.mdl" )

	-- Initalise physics
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:PhysicsInit( SOLID_VPHYSICS )

	-- Get the physics object
	local physicsObject = self:GetPhysicsObject()

	-- If the physics object is valid
	if physicsObject:IsValid() then

		-- Wake up the physics object
		physicsObject:Wake()

	end

end

-- Called when a player uses the entity
function ENT:Use( causer, proxy, type, value )

	-- If the causing entity is a player
	if causer:IsPlayer() then

		-- Print a simple message
		print( causer:Nick() .. " used me!" )

	end

end

-- Called every tick
function ENT:Think()

	-- Defy the fundamental laws of thermodynamics and create energy from nothing
	resourceDistribution.SupplyResource( self, "energy", 1 )

	-- Set the next tick to be one second from now
	self:NextThink( CurTime() + 1 )

	-- Apply the new tick time
	return true

end

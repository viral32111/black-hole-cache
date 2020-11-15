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

-- Get the Resource Distribution table
local resourceDistribution = CAF.GetAddon( "Resource Distribution" )

-- Get a table containing the names of all registered resources
local resourceNames = resourceDistribution.GetRegisteredResources()

-- Create colours to use for status indication
local colorRed = Color( 255, 0, 0 )
local colorGreen = Color( 0, 255, 0 )

-- Store the largest possible number that can be expressed (this is considered infinity)
local infinity = math.huge

-- Store a local copy of this function for optimisation
local currentTime = CurTime

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

	-- Is Wiremod installed?
	if WireAddon then

		-- Create the inputs
		Wire_CreateInputs( self, { "Activate" } )

		-- Create the outputs
		Wire_CreateOutputs( self, { "Active" } )

	end

	-- Register with Resource Distribution so we can link
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

		-- Is Wiremod installed?
		if WireAddon then

			-- Update the active output
			Wire_TriggerOutput( self, "Active", ( self.shouldSupply and 1 or 0 ) )

		end

	end

end

-- Called when a Wiremod input changes
function ENT:TriggerInput( name, value )

	-- Is it the activate input?
	if name == "Activate" then

		-- Toggle the status
		self.shouldSupply = tobool( value )

		-- Set new colour to indicate status
		self:SetColor( self.shouldSupply and colorGreen or colorRed )

		-- Is Wiremod installed?
		if WireAddon then

			-- Update the active output
			Wire_TriggerOutput( self, "Active", value )

		end

	end

end

-- Called every tick
function ENT:Think()

	-- Should we be supplying resources?
	if self.shouldSupply then

		-- Loop for the amount of reigstered resources
		for index = 1, #resourceNames do

			-- Fetch the name of the resource for this iteration
			local name = resourceNames[ index ]

			-- Defy the fundamental laws of thermodynamics to create an infinite resource from nothing
			resourceDistribution.SupplyResource( self, name, infinity )

		end

	end

	-- Set the next tick to be one second from now
	self:NextThink( currentTime() + 1 )

	-- Apply the new tick time
	return true

end

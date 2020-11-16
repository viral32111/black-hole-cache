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

-- Placeholder for the Resource Distribution table
local resourceDistribution = nil

-- Placeholder for the table of registered resource names
local resourceNames = nil

-- Is Spacebuild installed?
if CAF then

	-- Update the variable with the Resource Distribution table
	resourceDistribution = CAF.GetAddon( "Resource Distribution" )

	-- Update the variable with a table containing the names of all registered resources
	resourceNames = resourceDistribution.GetRegisteredResources()

end

-- Create colours to use for status indication
local colorRed = Color( 255, 0, 0 )
local colorGreen = Color( 0, 255, 0 )

-- Store the largest possible number before infinity: (2^1023)*1.9999999999999998
local largestNumber = 179769313486231570814527423731704356798070567525844996598917476803157260780028538760589558632766878171540458953514382464234321326889464182768467546703537516986049910576551282076245490090389328944075868508455133942304583236903222948165808559332123348274797826204144723168738177180919299881250404026184124858368

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

	-- Is Spacebuild installed?
	if CAF then

		-- Register with Resource Distribution so we can link
		resourceDistribution.RegisterNonStorageDevice( self )

	end

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

		-- Update the active output
		Wire_TriggerOutput( self, "Active", value )

	end

end

-- Called every tick
function ENT:Think()

	-- Should we be supplying resources and is Spacebuild installed?
	if self.shouldSupply and CAF then

		-- Loop for the amount of reigstered resources
		for index = 1, #resourceNames do

			-- Fetch the name of the resource for this iteration
			local name = resourceNames[ index ]

			-- Defy the fundamental laws of thermodynamics to create an infinite resource from nothing
			resourceDistribution.SupplyResource( self, name, largestNumber )

		end

	end

	-- Set the next tick to be one second from now
	self:NextThink( currentTime() + 1 )

	-- Apply the new tick time
	return true

end

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

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

local Increment = 2140000000

function ENT:Initialize()
	self.BaseClass.Initialize(self)
	self.Active = 0
	self.damaged = 0
	self.lastused = 0
	self.thinkcount = 0
	if not (WireAddon == nil) then
		self.WireDebugName = self.PrintName
		self.Inputs = Wire_CreateInputs(self.Entity, { "On" })
		self.Outputs = Wire_CreateOutputs(self.Entity, { "On" })
	else
		self.Inputs = {{Name="On"}}
	end
end

function ENT:TurnOn()
	if (self.Active == 0) then
		self.Active = 1
		if not (WireAddon == nil) then Wire_TriggerOutput(self.Entity, "On", self.Active) end
		self:SetOOO(1)
	elseif ( self.overdrive == 0 ) then
		self:TurnOnOverdrive()
	end
end

function ENT:TurnOff()
	if (self.Active == 1) then
		self.Active = 0
		
		if not (WireAddon == nil) then Wire_TriggerOutput(self.Entity, "On", self.Active) end
		self:SetOOO(0)
	end
end

function ENT:SetActive( value )
	if (value) then
		if (value != 0 and self.Active == 0 ) then
			self:TurnOn()
		elseif (value == 0 and self.Active == 1 ) then
			self:TurnOff()
		end
	else
		if ( self.Active == 0 ) then
			self.lastused = CurTime()
			self:TurnOn()
		else
			if not ((( CurTime() - self.lastused) < 2 )) then
				self:TurnOff()
			end
		end
	end
end

function ENT:TriggerInput(iname, value)
	if (iname == "On") then
		self:SetActive(value)
	end
end

function ENT:Damage()
	if (self.damaged == 0) then
		self.damaged = 1
	end
	if ((self.Active == 1) and (math.random(1, 10) <= 4)) then
		self:TurnOff()
	end
end

function ENT:Repair()
	self.BaseClass.Repair(self)
	self.damaged = 0
end

function ENT:Destruct()
	if CAF and CAF.GetAddon("Life Support") then
		CAF.GetAddon("Life Support").Destruct( self.Entity, true )
	end
end

function ENT:OnRemove()
	self.BaseClass.OnRemove(self)
end

function ENT:BlackHoleCache()
	local inc = Increment
	if (inc >= math.Round(inc/2)) then
		self:SupplyResource("water", inc)
		self:SupplyResource("oxygen", inc)
		self:SupplyResource("nitrogen", inc)
		self:SupplyResource("liquid nitrogen", inc)
		self:SupplyResource("energy", inc)
		self:SupplyResource("heavy water", inc)
		self:SupplyResource("carbon dioxide", inc)
		self:SupplyResource("steam", inc)
		self:SupplyResource("hydrogen", inc)
		self:SupplyResource("hot liquid nitrogen", inc)
		self:SupplyResource("methane", inc)
		self:SupplyResource("propane", inc)
		self:SupplyResource("deuterium", inc)
		self:SupplyResource("tritium", inc)
	else
		self:TurnOff()
	end
end

function ENT:Think()
	self.BaseClass.Think(self)
	self.thinkcount = self.thinkcount + 1
	if self.thinkcount == 10 then
		if ( self.Active == 1 ) then self:BlackHoleCache() end
		self.thinkcount = 0
	end
	self.Entity:NextThink( CurTime() + 0.1 )
	return true
end


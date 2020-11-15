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

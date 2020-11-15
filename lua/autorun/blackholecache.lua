--[[------------------------------------------------------------------------------
Black Hole Cache - An infinite resource generator & storage device for Spacebuild.
Copyright (C) 2018 - 2020 viral32111 (https://viral32111.com).

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

BlackHoleCache = {}
BlackHoleCache.Version = 003
BlackHoleCache.Name = "Black Hole Cache"

hook.Add("PlayerConnect", BlackHoleCache.Name .. "VersionCheck", function()
	http.Fetch("https://raw.githubusercontent.com/viral32111/black-hole-cache/master/README.md", function( LatestVersion )
		local LatestVersion = tonumber( string.sub( LatestVersion, string.len( BlackHoleCache.Name )+18, string.len( BlackHoleCache.Name )+21 ) )
		if ( LatestVersion == BlackHoleCache.Version ) then
			print("[" .. BlackHoleCache.Name .. "] You are running the latest version!")
		elseif ( LatestVersion > BlackHoleCache.Version ) then
			print("[" .. BlackHoleCache.Name .. "] You are running an outdated version! (Latest: " .. LatestVersion .. ", Current: " .. BlackHoleCache.Version .. ")")
		elseif ( LatestVersion < BlackHoleCache.Version ) then
			print("[" .. BlackHoleCache.Name .. "] You are running a future version, Please reinstall the addon. (Latest: " .. LatestVersion .. ", Current: " .. BlackHoleCache.Version .. ")")
		else
			print("[" .. BlackHoleCache.Name .. "] Failed to parse addon version! (Latest: " .. LatestVersion .. ", Current: " .. BlackHoleCache.Version .. ")")
		end
	end, function( error )
		print("[" .. BlackHoleCache.Name .. "] Failed to get addon version! (" .. error .. ")")
	end )

	hook.Remove("PlayerConnect", BlackHoleCache.Name .. "VersionCheck")
end )

print("[" .. BlackHoleCache.Name .. "] Loaded Version: " .. BlackHoleCache.Version )

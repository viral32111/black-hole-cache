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

BlackHoleCache = {}
BlackHoleCache.Version = 002
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
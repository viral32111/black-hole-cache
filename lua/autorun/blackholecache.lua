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

local Version = "1.0.0"

if ( SERVER ) then
	print("[Black Hole Cache] Loaded Version: " .. Version )
end

if ( CLIENT ) then
	print("Thanks for using Black Hole Cache, Created by viral32111!")
end

hook.Add( "PlayerConnect", "BlackHoleCacheVersionCheck", function()
	http.Fetch( "https://raw.githubusercontent.com/viral32111/black-hole-cache/master/VERSION.txt", function( body, len, headers, code )
		local body = string.gsub( body, "\n", "" )
		if ( body == Version ) then
			print( "[Black Hole Cache] You are running the most recent version of Black Hole Cache!" )
		elseif ( body == "404: Not Found" ) then
			print( "[Black Hole Cache] Version page does not exist")
		else
			print( "[Black Hole Cache] You are using outdated version of Black Hole Cache! (Latest: " .. body .. ", Current: " .. Version .. ")" )
		end
	end,
	function( error )
		print( "[Black Hole Cache] Failed to get addon version! (" .. error .. ")" )
	end )

	hook.Remove( "PlayerConnect", "BlackHoleCacheVersionCheck" )
end )

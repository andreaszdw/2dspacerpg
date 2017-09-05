-------------------------------------------------------------------------------
--
-- player.lua
--
-- project: 2dspacerpg
--
-- this is the players ship
--
-- andreaszdw@googlemail.com
--
-------------------------------------------------------------------------------

local json = require("json")

local player = {}
local player_mt = { __index = player }	-- metatable

-----------------------------------------------------------
--
-- constructor
--
-----------------------------------------------------------
function player.new()	
	local newPlayer = {
		speed = speed or 0,
		image = image or ""
	}
	return setmetatable( newPlayer, player_mt )
end

-----------------------------------------------------------
--
-- create the starfield
--
-----------------------------------------------------------
function player:create(x, y, jsonFile)

	local decoded, pos, msg = json.decodeFile(jsonFile)

	if not decoded then
		print ("decode failed at" .. tostring(pos)..": "..tostring(msg))
	else
		self.image = display.newImage(mainSheet, sheetInfo:getFrameIndex(decoded.image))
		self.image.x = x
		self.image.y = y
	end

end

----------------------------------------------------------
--
-- rotate
--
----------------------------------------------------------
function player:rotate(degree)

	self.image.rotation = degree

end

-----------------------------------------------------------
--
-- update it
--
-----------------------------------------------------------
function player:update()
end

-----------------------------------------------------------
return player
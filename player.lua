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

-----------------------------------------------------------
--
-- constructor
--
-----------------------------------------------------------
function player:new()
	o = {
		maxspeed = maxspeed or 0, -- per second
		speed = speed or 0, -- per second
		acceleration = acceleration or o, -- per second
		turnSpeed = turnSpeed or 0, -- per second
		stickAngle = 0,
		stickPercent = 0,
		image = image or ""
	}
	setmetatable(o, self)
	self.__index = self
	return o
end

-----------------------------------------------------------
--
-- create the player
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
		self.maxSpeed = tonumber(decoded.maxSpeed)
		self.turnSpeed = tonumber(decoded.turnSpeed)
		self.acceleration = tonumber(decoded.acceleration)
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
-- setStick
--
-----------------------------------------------------------
function player:setStick(percent, angle)

	self.stickPercent = percent
	self.stickAngle = angle

end

-----------------------------------------------------------
--
-- update it
--
-----------------------------------------------------------
function player:update()

	local source = self.image.rotation 
	local destination = self.stickAngle
	local diff = source - destination + 360

	local turnDirection = 0

	if (diff % 360) > 180 then
		turnDirection = 1
	else
		turnDirection = -1
	end

	self.image.rotation = self.image.rotation + self.turnSpeed/60 * turnDirection
	self.image.rotation = self.image.rotation % 360

end

-----------------------------------------------------------
--
-- get position
--
-----------------------------------------------------------
function player:getPosition()

	return self.image.x, self.image.y

end

-----------------------------------------------------------
--
-- get speed
--
-----------------------------------------------------------
function player:getSpeed()
	
	return self.speed

end

-----------------------------------------------------------
--
-- get angle
--
-----------------------------------------------------------
function player:getAngle()

	return self.image.rotation

end

-----------------------------------------------------------
return player
-------------------------------------------------------------------------------
--
-- starfield.lua
--
-- project: 2dspacerpg
--
-- this is the main game scene
--
-- andreaszdw@googlemail.com
--
-------------------------------------------------------------------------------

local starfield = {}
--local starfield_mt = { __index = starfield }	-- metatable

-----------------------------------------------------------
--
-- constructor
--
-----------------------------------------------------------
function starfield.new(total, starsMaxSize, speed, minScaleSize)	
	o = {
		stars = {},
		total = total or 600,
		group = group,
		field1 = 0,
		field2 = 0,
		field3 = 0,
		speed = speed or 1,
		starsMaxSize = starsMaxSize or 5,
		minScaleSize = minScaleSize or 0.5
	}
	setmetatable(o, self)
	self.__index = self
	return o
end

-----------------------------------------------------------
--
-- create the starfield
--
-----------------------------------------------------------
function starfield:create(group)

	self.field1 = self.total/3
	self.field2 = self.field1 + self.total/3
	self.field3 = self.field2 + self.field2

	for i = 1, self.total do
		local star = {} 
		self.starSize = math.random(self.starsMaxSize)
		star.object = display.newRect(math.random(display.contentWidth*1/self.minScaleSize),math.random(display.contentHeight*1/self.minScaleSize), self.starSize, self.starSize)
		star.object:setFillColor(1, 1, 1, math.random(30, 100)/100)
		group:insert(star.object)
		self.stars[i] = star
	end

end

-----------------------------------------------------------
--
-- update it
--
-----------------------------------------------------------
function starfield:update(percent, angle)

	local angleRad = (math.pi * angle) / 180
	local normalizedX = math.cos(angleRad)
	local normalizedY = math.sin(angleRad)
	
	local starspeed = 0.0

    for i = self.total, 1, -1 do
        if i < self.field1 then
            starspeed = 0.2 * self.speed * percent
        end
        if i < self.field2 and i > self.field1 then
            starspeed = 0.4 * self.speed * percent
        end
        if i < self.field3 and i > self.field2 then
            starspeed = 0.6 * self.speed * percent
        end
        
        self.stars[i].object.y  = self.stars[i].object.y + starspeed  * normalizedX        
        self.stars[i].object.x  = self.stars[i].object.x - starspeed  * normalizedY

        if self.stars[i].object.y > display.contentHeight * 1/self.minScaleSize then
        	self.stars[i].object.y = 0
        end

        if self.stars[i].object.y < 0 then
         	self.stars[i].object.y = display.contentHeight * 1/self.minScaleSize
        end

        if self.stars[i].object.x > display.contentWidth * 1/self.minScaleSize then
        	self.stars[i].object.x = 0
        end
        if self.stars[i].object.x < 0 then
        	self.stars[i].object.x = display.contentWidth * 1/self.minScaleSize
        end
	end
end

-----------------------------------------------------------
return starfield
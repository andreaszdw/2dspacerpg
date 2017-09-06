-------------------------------------------------------------------------------
--
-- view.lua
--
-- project: 2dspacerpg
--
-- the view, can be scrolled and scaled
--
-- andreaszdw@googlemail.com
--
-------------------------------------------------------------------------------

-- add starfield
--local sf = require("starfield")

local view = {}
--local view_mt = { __index = view }	-- metatable

-----------------------------------------------------------
--
-- constructor
--
-----------------------------------------------------------
function view:new()	
	o = {
		x = x or 0, -- the center of view
		y = y or 0, -- the center of view
		maxZoom = maxZoom or 1,
		minZoom = minZoom or 0.5,
		zoom = zoom or 1,
		sfGroup, -- display group for the starfield		
		starfield, -- the starfield
		entityGroup,
	}
	setmetatable(o, self)
	self.__index = self
	return o
end

-----------------------------------------------------------
--
-- create the view
--
-----------------------------------------------------------
function view:create()

	--[[the starfield background
	self.starfield = sf:new(200, 7, 20, self.minZoom)
	self.sfGroup = display.newGroup()
	self.sfGroup.anchorX, self.sfGroup.anchorY = 0.5, 0.5

	self.starfield:create(self.sfGroup)
	--self.sfGroup:scale(0.5, 0.5)]]--

	-- the entities
	self.entityGroup = display.newGroup()

end

-----------------------------------------------------------
--
-- add to entity group
--
-----------------------------------------------------------
function view:addToEntityGroup(object)

	self.entityGroup:insert(object)

end

-----------------------------------------------------------
--
-- update it
--
-----------------------------------------------------------
function view:update(p, a)

	--[[self.sfGroup.xScale = self.zoom
	self.sfGroup.xScale = self.zoom
	self.starfield:update(p, a)]]--


end

-----------------------------------------------------------
--
-- set zoom
--
-----------------------------------------------------------
function view:setZoom(zoom)

	self.zoom = zoom

	if self.zoom < self.minZoom then self.zoom = self.minZoom end

	if self.zoom > self.maxZoom then self.zoom = self.maxZoom end
	self.entityGroup.xScale, self.entityGroup.yScale = self.zoom, self.zoom

end

-----------------------------------------------------------
--
-- get zoom
--
-----------------------------------------------------------
function view:getZoom()
	return self.zoom
end

-----------------------------------------------------------
--
-- focus it
--
-----------------------------------------------------------
function view:focus(x, y)

	self.entityGroup.x, self.entityGroup.y = x+display.contentWidth/2, y+display.contentHeight/2	
end

-----------------------------------------------------------
return view
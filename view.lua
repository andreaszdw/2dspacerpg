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
local sf = require("starfield")

local view = {}
local view_mt = { __index = view }	-- metatable

-----------------------------------------------------------
-- constructor
-----------------------------------------------------------
function view.new()	
	local newView = {
		sfGroup,
		starfield
	}
	return setmetatable(newView, view_mt)
end

-----------------------------------------------------------
-- create the view
-----------------------------------------------------------
function view:create()

	--the starfield background
	self.starfield = sf.new(200, 7, 20, 2)
	self.sfGroup = display.newGroup()

	self.starfield:create(self.sfGroup)
	self.sfGroup:scale(0.5, 0.5)

end

-----------------------------------------------------------
-- update it
-----------------------------------------------------------
function view:update(p, a)

	self.starfield:update(p, a)

end

-----------------------------------------------------------
-- focus it
-----------------------------------------------------------
function view:focus()

end

-----------------------------------------------------------
return view
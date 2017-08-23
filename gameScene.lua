-------------------------------------------------------------------------------
--
-- gameScene.lua
--
-- project: 2dspacerpg
--
-- this is the main game scene
--
-- andreaszdw@googlemail.com
--
-------------------------------------------------------------------------------

-- add composer
local composer = require("composer")

-- add the sheet
local sheetInfo = require("sheet") --("shooterSheet")

-- add physics
local physics = require("physics")

-- add analog stick
local StickLib = require("lib_analog_stick")

-- new image sheet
local shooterSheet = graphics.newImageSheet ("assets/images/sheet.png", sheetInfo:getSheet()) --( "assets/images/shooterSheet.png", sheetInfo:getSheet() )

-- init physics
physics.start()
physics.setGravity(0, 0)

-- new scene
local scene = composer.newScene()

-- new display groups
local backGroup = display.newGroup()
local playerShotGroup = display.newGroup()
local mainGroup = display.newGroup()
local uiGroup = display.newGroup()

-- two sticks
local stickShip -- for the ship
local stickGun -- for the gun

-- set text
local topText = display.newText( uiGroup, "", display.contentWidth/2, 150, "assets/fonts/kenvector_future.ttf", 100 )

local gradient = {
    type="gradient",
    color1={1, 0, 0}, color2={1, 1, 0}, direction="down"
}

topText:setFillColor(gradient)

-- activate multitouch
system.activate("multitouch")

-----------------------------------------------------------
--
-- the update function, on every enterframe even
--
-----------------------------------------------------------
local function update(event)

end

-----------------------------------------------------------
--
-- the collision function, on every collision
--
-----------------------------------------------------------
local function onCollision(event)

end

-----------------------------------------------------------
-- 
-- now the scene functions coming
-----------------------------------------------------------
function scene:create(event)

	physics.pause()

	-- create stick for the ship
	stickShip = StickLib.NewStick(
	{
		x = display.contentWidth*.15,
		y = display.contentHeight*.85,
		imageSheet = shooterSheet,
		imageMain = sheetInfo:getFrameIndex("joystickMain"),
		imageThumb = sheetInfo:getFrameIndex("joystickThumb"),
		scale = 2.0,
		borderSize = 64,
		snapBackSpeed = .2,
		R = 255,
		G = 0, 
		B = 0
	})

	-- create stick for the gun
	stickGun = StickLib.NewStick(
	{
		x = display.contentWidth*.85,
		y = display.contentHeight*.85,
		imageSheet = shooterSheet,
		imageMain = sheetInfo:getFrameIndex("joystickMain"),
		imageThumb = sheetInfo:getFrameIndex("joystickThumb"),
		scale = 2.0,
		borderSize = 64,
		snapBackSpeed = .2,
		R = 255,
		G = 0, 
		B = 0
	})

	physics.start()
end

-----------------------------------------------------------
function scene:show(event)

	local phase = event.phase

	if (phase == "will") then

	elseif (phase == "did") then

		physics.start()
	end
end

-----------------------------------------------------------
function scene:hide(event)
end

-----------------------------------------------------------
function scene:destroy(event)
end

-----------------------------------------------------------
--
-- add event listener
--
-----------------------------------------------------------
scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)

Runtime:addEventListener("enterFrame", update)
Runtime:addEventListener("collision", onCollision)

-----------------------------------------------------------
return scene
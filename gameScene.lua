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
local StickLib = require("analog_stick.lib_analog_stick")

-- add the view
local view = require("view")
local camera = view.new()
camera:create()

-- set defaults
display.setDefault("background", 0.05, 0.05, 0.28)

-- new image sheet
local mainSheet = graphics.newImageSheet ("assets/images/sheet.png", sheetInfo:getSheet()) --( "assets/images/shooterSheet.png", sheetInfo:getSheet() )

-- init physics
physics.start()
physics.setGravity(0, 0)

-- new scene
local scene = composer.newScene()

-- display group, must be the last defined, so it is in the foreground
local uiGroup = display.newGroup()

-- two sticks
local stickShip -- for the ship
local stickGun -- for the gun

-- set Info text for stickShip
local infoText = display.newText( uiGroup, "Info Text", 10, 10, "assets/fonts/kenvector_future.ttf", 40 )
infoText.anchorX = 0
infoText.anchorY = 0

local gradient = {
    type="gradient",
    color1={1, 0, 0}, color2={1, 1, 0}, direction="down"
}

infoText:setFillColor(gradient)

-- activate multitouch
system.activate("multitouch")

-----------------------------------------------------------
--
-- the update function, on every enterframe even
--
-----------------------------------------------------------
local function onEnterFrame(event)

	infoText.text = "Info Text"

	-- update the camera
	camera:update(stickShip:getPercent(), stickShip:getAngle())

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
		x = 210,
		y = 800,
		imageSheet = mainSheet,
		imageMain = sheetInfo:getFrameIndex("joystickMain"),
		imageThumb = sheetInfo:getFrameIndex("joystickThumb"),
		scale = 2.0,
		borderSize = 64,
		snapBackSpeed = .2,
		R = 0,
		G = 0, 
		B = 0
	})

	-- create stick for the gun
	stickGun = StickLib.NewStick(
	{
		x = 1710,
		y = 800,
		imageSheet = mainSheet,
		imageMain = sheetInfo:getFrameIndex("joystickMain"),
		imageThumb = sheetInfo:getFrameIndex("joystickThumb"),
		scale = 2.0,
		borderSize = 64,
		snapBackSpeed = .2,
		R = 0,
		G = 0, 
		B = 0
	})

	uiGroup:insert(stickShip)
	uiGroup:insert(stickGun)

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

Runtime:addEventListener("enterFrame", onEnterFrame)
Runtime:addEventListener("collision", onCollision)

-----------------------------------------------------------
return scene
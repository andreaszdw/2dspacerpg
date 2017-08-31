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

-- add starfield
local sf = require("starfield")

-- set defaults
display.setDefault("background", 0.05, 0.05, 0.28)

-- new image sheet
local mainSheet = graphics.newImageSheet ("assets/images/sheet.png", sheetInfo:getSheet()) --( "assets/images/shooterSheet.png", sheetInfo:getSheet() )

-- init physics
physics.start()
physics.setGravity(0, 0)

-- new scene
local scene = composer.newScene()

-- new display groups
local sfGroup = display.newGroup()
local uiGroup = display.newGroup()

-- the starfield background
local starfield = sf.new(100, 5, 20)
starfield:create(sfGroup)

-- two sticks
local stickShip -- for the ship
local stickGun -- for the gun

-- set Info text for stickShip
local stickShipHeader = display.newText( uiGroup, "Stick Ship", 10, 10, "assets/fonts/kenvector_future.ttf", 40 )
stickShipHeader.anchorX = 0
stickShipHeader.anchorY = 0

local stickShipAngle = display.newText( uiGroup, "Angle: 0", 10, 50, "assets/fonts/kenvector_future.ttf", 40 )
stickShipAngle.anchorX = 0
stickShipAngle.anchorY = 0

local stickShipDistance = display.newText( uiGroup, "Distance: 0", 10, 90, "assets/fonts/kenvector_future.ttf", 40 )
stickShipDistance.anchorX = 0
stickShipDistance.anchorY = 0

local stickShipPercent = display.newText( uiGroup, "Percent: 0", 10, 130, "assets/fonts/kenvector_future.ttf", 40 )
stickShipPercent.anchorX = 0
stickShipPercent.anchorY = 0

-- set Info text for stickGun
local stickGunHeader = display.newText( uiGroup, "Stick Ship", 1510, 10, "assets/fonts/kenvector_future.ttf", 40 )
stickGunHeader.anchorX = 0
stickGunHeader.anchorY = 0

local stickGunAngle = display.newText( uiGroup, "Angle: 0", 1510, 50, "assets/fonts/kenvector_future.ttf", 40 )
stickGunAngle.anchorX = 0
stickGunAngle.anchorY = 0

local stickGunDistance = display.newText( uiGroup, "Distance: 0", 1510, 90, "assets/fonts/kenvector_future.ttf", 40 )
stickGunDistance.anchorX = 0
stickGunDistance.anchorY = 0

local stickGunPercent = display.newText( uiGroup, "Percent: 0", 1510, 130, "assets/fonts/kenvector_future.ttf", 40 )
stickGunPercent.anchorX = 0
stickGunPercent.anchorY = 0

local gradient = {
    type="gradient",
    color1={1, 0, 0}, color2={1, 1, 0}, direction="down"
}

stickShipHeader:setFillColor(gradient)
stickShipAngle:setFillColor(gradient)
stickShipDistance:setFillColor(gradient)
stickShipPercent:setFillColor(gradient)

stickGunHeader:setFillColor(gradient)
stickGunAngle:setFillColor(gradient)
stickGunDistance:setFillColor(gradient)
stickGunPercent:setFillColor(gradient)

-- activate multitouch
system.activate("multitouch")

-----------------------------------------------------------
--
-- the update function, on every enterframe even
--
-----------------------------------------------------------
local function onEnterFrame(event)

	stickShipAngle.text = "Angle: " .. stickShip:getAngle()
	stickShipDistance.text = "Distance: " .. stickShip:getDistance()
	stickShipPercent.text = "Percent: " .. stickShip:getPercent()

	stickGunAngle.text = "Angle: " .. stickGun:getAngle()
	stickGunDistance.text = "Distance: " .. stickGun:getDistance()
	stickGunPercent.text = "Percent: " .. stickGun:getPercent()

	starfield:update(stickShip:getPercent(), stickShip:getAngle())

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
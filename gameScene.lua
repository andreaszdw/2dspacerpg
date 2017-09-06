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

-- important minSheet and sheetInfo, have to be globals
-- add the sheet
sheetInfo = require("sheet") --("shooterSheet")

-- new image sheet
mainSheet = graphics.newImageSheet ("assets/images/sheet.png", sheetInfo:getSheet())

-- add physics
local physics = require("physics")

-- add analog stick
local StickLib = require("analog_stick.lib_analog_stick")

-- for buttons
local widget = require("widget")

-- add the view
local view = require("view")
local camera = view:new()
camera:create()

-- the player
local pl = require("player")

-- set defaults
display.setDefault("background", 0.05, 0.05, 0.28)

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

-- set Info text for ship
local infoText = display.newText( uiGroup, "Ship position: ", 10, 10, "assets/fonts/kenvector_future.ttf", 40 )
infoText.anchorX = 0
infoText.anchorY = 0

local infoText2 = display.newText( uiGroup, "Ship speed/angle: ", 10, 50, "assets/fonts/kenvector_future.ttf", 40 )
infoText2.anchorX = 0
infoText2.anchorY = 0

local gradient = {
    type="gradient",
    color1={1, 0, 0}, color2={1, 1, 0}, direction="down"
}

infoText:setFillColor(gradient)
infoText2:setFillColor(gradient)

-- activate multitouch
system.activate("multitouch")

-- function to handle button scaleDown
local function handleScaleDownButtonEvent(event)

	if("ended" == event.phase) then
		print("ScaleDown released")
		camera:setZoom(camera:getZoom() + 0.1)
	end
end

-- now the scaleDownButton
local scaleDownButton = widget.newButton(
	{
		left = 1800,
		top = 60,
		width = 80,
		height = 80,
		label = "-",
		font = "assets/fonts/kenvector_future.ttf",
		fontSize = 40,
		onEvent = handleScaleDownButtonEvent,
		shape = "roundedRect",
        fillColor = { default={1,0,0,1}, over={1,0.1,0.7,0.4} },
        strokeColor = { default={1,0.4,0,1}, over={0.8,0.8,1,1} },
        strokeWidth = 4
	}
)

-- function to handle button scaleDown
local function handleScaleUpButtonEvent(event)

	if("ended" == event.phase) then
		camera:setZoom(camera:getZoom() - 0.1)
	end
end

-- now the scaleDownButton
local scaleUpButton = widget.newButton(
	{
		left = 1800,
		top = 200,
		width = 80,
		height = 80,
		id = "scaleUpButton",
		label = "+",
		font = "assets/fonts/kenvector_future.ttf",
		fontSize = 40,
		onEvent = handleScaleUpButtonEvent,
		shape = "roundedRect",
        fillColor = { default={1,0,0,1}, over={1,0.1,0.7,0.4} },
        strokeColor = { default={1,0.4,0,1}, over={0.8,0.8,1,1} },
        strokeWidth = 4
	}
)

-----------------------------------------------------------
--
-- the update function, on every enterframe even
--
-----------------------------------------------------------
local function onEnterFrame(event)

	infoText.text = "Ship position: " .. player.image.x .. "-" .. player.image.y
	infoText2.text = "Ship speed: " .. player:getSpeed() .. " angle: " .. player:getAngle()

	player:update()
	-- update the camera
	--camera:update(stickShip:getPercent(), stickShip:getAngle())
	--player:rotate(stickShip:getAngle())
	player:setStick(stickShip:getPercent(), stickShip:getAngle())

end

-----------------------------------------------------------
--
-- load level
--
-----------------------------------------------------------
local function loadLevel()

	player = pl:new()
	player:create(0, 0, "assets/jsons/ship01.json")
	camera:addToEntityGroup(player.image)
	camera:focus(0, 0)
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
-- on touch function
--
-----------------------------------------------------------
local function onTouch(event)

end
-----------------------------------------------------------
-- 
-- now the scene functions coming
--
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

	loadLevel()
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
Runtime:addEventListener("touch", onTouch)

-----------------------------------------------------------
return scene
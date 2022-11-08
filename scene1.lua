local composer = require( "composer" )
local scene = composer.newScene()
 
---------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE
-- unless "composer.removeScene()" is called.
---------------------------------------------------------------------------------
 
-- local forward references should go here
 
---------------------------------------------------------------------------------
 
local xRef = 150
local yRef = 200

local weight = true
local disp = false
local mileage = false

-- "scene:create()"
function scene:create( event )
 
   local sceneGroup = self.view

   local function next()
        composer.gotoScene("scene2", {
                effect = "slideUp",
                time = 100,
                params = {
                    weight = weight;
                    disp = disp;
                    mileage = mileage;
            } 
        });
    end

    function buttonListener(event) 
        composer.gotoScene("scene2", {
            effect = "slideUp",
            time = 100,
            params = {
                weight = weight;
                disp = disp;
                mileage = mileage;
            } 
        });
    end

    local button1 = display.newRect( 500, 50, 100, 50 )
    button1.strokeWidth = 3
    button1:setFillColor( 1,1,1 )
    button1:setStrokeColor( 1, 0, 0 )
    button1:addEventListener( "tap", buttonListener )
    sceneGroup:insert(button1)

   local function onSwitchPressWeight( event )
        weight = event.target.isOn
        disp = false
        mileage = false

        --next();
    end
   local weightButton = widget.newSwitch(
        {
            left = xRef,
            top = yRef + 50,
            style = "radio",
            id = "RadioButton1",
            initialSwitchState = true,
            onPress = onSwitchPressWeight
        }
    )
    sceneGroup:insert(weightButton)
    local t1 = display.newText( "Weight", xRef + 80, yRef + 60, native.systemFont, 24 )
    t1:setFillColor( 1, 1, 1 )
    sceneGroup:insert(t1)

    local function onSwitchPressDisp( event )
        disp = event.target.isOn
        weight = false
        mileage = false
        -- next();
    end
   local dispButton = widget.newSwitch(
        {
            left = xRef,
            top = yRef + 100,
            style = "radio",
            id = "RadioButton2",
            initialSwitchState = false,
            onPress = onSwitchPressDisp
        }
    ) 
    sceneGroup:insert(dispButton)
    local t2 = display.newText( "Disp", xRef + 80, yRef + 115, native.systemFont, 24 )
    t2:setFillColor( 1, 1, 1 )
    sceneGroup:insert(t2)

    local function onSwitchPressMileage( event )
        mileage = event.target.isOn
        weight = false
        disp = false
        --next();
    end
   local MileageButton = widget.newSwitch(
        {
            left = xRef,
            top = yRef + 150,
            style = "radio",
            id = "RadioButton3",
            initialSwitchState = false,
            onPress = onSwitchPressMileage
        }
    ) 
    sceneGroup:insert(MileageButton)
    local t3 = display.newText( "Mileage", xRef + 80, yRef + 165, native.systemFont, 24 )
    t3:setFillColor( 1, 1, 1 )
    sceneGroup:insert(t3)
end
 
-- "scene:show()"
function scene:show( event )
 
   local sceneGroup = self.view
   local phase = event.phase
 
   if ( phase == "will" ) then
      -- Called when the scene is still off screen (but is about to come on screen).
   elseif ( phase == "did" ) then
      -- Called when the scene is now on screen.
      -- Insert code here to make the scene come alive.
      -- Example: start timers, begin animation, play audio, etc.
   end
end
 
-- "scene:hide()"
function scene:hide( event )
 
   local sceneGroup = self.view
   local phase = event.phase
 
   if ( phase == "will" ) then
      -- Called when the scene is on screen (but is about to go off screen).
      -- Insert code here to "pause" the scene.
      -- Example: stop timers, stop animation, stop audio, etc.
   elseif ( phase == "did" ) then
      -- Called immediately after scene goes off screen.
   end
end
 
-- "scene:destroy()"
function scene:destroy( event )
 
   local sceneGroup = self.view
 
   -- Called prior to the removal of scene's view ("sceneGroup").
   -- Insert code here to clean up the scene.
   -- Example: remove display objects, save state, etc.
end
 
---------------------------------------------------------------------------------
 
-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
 
---------------------------------------------------------------------------------
 
return scene
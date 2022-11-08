local composer = require( "composer" )
local scene = composer.newScene()
local file = require("file")
---------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE
-- unless "composer.removeScene()" is called.
---------------------------------------------------------------------------------
 
-- local forward references should go here
 
---------------------------------------------------------------------------------
 
-- "scene:create()"

local group = display.newGroup()
local weight = false
local disp = false
local mileage = false
local data

function scene:create( event )
     
    local sceneGroup = self.view

    local function handleButtonEvent( event )
        if ( "ended" == event.phase ) then
            composer.gotoScene("scene1", {
                effect = "slideUp",
                time = 100,
            });
        end
    end
    local button1 = widget.newButton(
        {
            left = 500,
            top = 0,
            id = "button1",
            label = "Default",
            onEvent = handleButtonEvent,
            width = 10,
            height = 10
        }
    )
    sceneGroup:insert(button1)

    function tapListener(event) 
        file.printData(data, 'json')
        print(event.target.text)
    end

    function makeCircle(x, y, radius, c1, c2, c3, text, weight, disp, mileage)
        local circleGroup = display.newGroup();

        local randomX = 50+ math.random() * 500
        local randomY = math.random() * 1000 
        local myCircle = display.newCircle( randomX, randomY, radius, 0.6 )
        myCircle:setFillColor( c1, c2, c3 )
        myCircle.strokeWidth = 5
        myCircle:setStrokeColor( 1, 1, 1 )
        local t2 = display.newText( text, randomX, randomY, native.systemFont, 24 )
        t2:setFillColor( 1, 0, 1 )
        t2:addEventListener( "tap", tapListener )
        -- circleGroup.insert({
        --     disp = disp
        -- })
        -- circleGroup.insert(disp)
        -- circleGroup.insert(mileage)
        -- circleGroup:insert(t2)
        -- circleGroup:insert(myCircle)
        circleGroup:insert(t2)
        circleGroup:insert(myCircle)
        --group:insert(myCircle)
        group:insert(circleGroup)
        --group:insert(circleGroup)
    end
 
    function map (value, istart, istop, ostart, ostop) 
        return ostart + (ostop - ostart) * ((value - istart) / (istop - istart));
    end
   -- Initialize the scene here.
   -- Example: add display objects to "sceneGroup", add touch listeners, etc.
end
 
-- "scene:show()"
function scene:show( event )
 
   local sceneGroup = self.view
   local phase = event.phase
    data = file.readCSV("car.csv")
    weight = event.params.weight;
    disp = event.params.disp;
    mileage = event.params.mileage;

    local maxMileage = -999999
    local minMileage = 999999
    local maxWeight = -999999
    local minWeight = 999999
    local maxDisp = -999999
    local minDisp = 999999
    --Car,Weight,Disp,Mileage,Type
    local count = 0
    for fields in data:lines() do
        if(count == 0) then
            print("counnnnt")
        else
            local fields2 = tonumber(fields[2])
            local fields3 = tonumber(fields[3])
            
            if(tonumber(fields[2]) < minWeight) then
                minWeight = tonumber(fields[2])
            end
            if(tonumber(fields[2]) > maxWeight) then
                maxWeight = tonumber(fields[2])
            end
    
            if(tonumber(fields[3]) < minDisp) then
                minDisp = tonumber(fields[3])
            end
            if(tonumber(fields[3]) > maxDisp) then
                maxDisp = tonumber(fields[3])
            end
    
            if(tonumber(fields[4]) < minMileage) then
                minMileage = tonumber(fields[4])
            end
            if(tonumber(fields[4]) > maxMileage) then
                maxMileage = tonumber(fields[4])
            end
        end
        count = count + 1
    end



   if ( phase == "will" ) then
        group = display.newGroup()
        local count = 0
        for fields in data:lines() do
            if (count == 0) then
                print("count is 0")
            else
                print(v, fields[1], fields[2], fields[3], fields[4], fields[5])
                local c1, c2, c3
                local radius
                if(fields[5] == "Small") then
                    c1 = 1;
                    c2 = 0;
                    c3 = 0;
                elseif(fields[5] == 'Compact') then
                    c1 = 0;
                    c2 = 1;
                    c3 = 1;
                elseif(fields[5] == 'Medium') then
                    c1 = 0;
                    c2 = 0;
                    c3 = 1;
                else
                    c1 = 0;
                    c2 = 1;
                    c3 = 1;
                end
                --Car,Weight,Disp,Mileage,Type
                local radius
                if(weight == true) then
                    radius = map(tonumber(fields[2]), minWeight, maxWeight, 10,50)
                elseif(disp == true) then
                    radius = map(tonumber(fields[3]), minDisp, maxDisp, 10,50)
                elseif(mileage == true) then
                    radius = map(tonumber(fields[4]), minMileage, maxMileage, 10,50)
                end
                makeCircle(0,0,radius, c1, c2, c3, fields[1], fields[2], fields[3], fields[4])
            end
            count = count + 1
        end
   elseif ( phase == "did" ) then
        print("wassssssupppppppppppppppp")
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
        display.remove(group)
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
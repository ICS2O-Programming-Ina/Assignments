-----------------------------------------------------------------------------------------
--
-- level1_squirrel.lua
-- Created by: Ms Raffin
-- Date: Nov. 22nd, 2014
-- Description: This is the level 1 screen of the game.
-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
-- INITIALIZATIONS
-----------------------------------------------------------------------------------------

-- Use Composer Libraries
local composer = require( "composer" )
local widget = require( "widget" )

-- load physics
local physics = require("physics")

-----------------------------------------------------------------------------------------

-- Naming Scene
sceneName = "level1_screen"

-----------------------------------------------------------------------------------------

-- Creating Scene Object
local scene = composer.newScene( sceneName )

-----------------------------------------------------------------------------------------
-- GLOBAL VARIABLES
-----------------------------------------------------------------------------------------
soundOn = true 

-----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------

-- The local variables for this scene
local bkg_image

local platform1
local platform2
local platform4
local platform5
local platform6

local leaf1
local leaf2 
local leaf3
local leaf4
local leaf5
local leaf6

local fence1
local fence2
local fence3
local fence4

local torchesAndSign
local door
local door
local squirrel

local heart1
local heart2
local heart3
local numLives = 3

local rArrow 
local uArrow
local lArrow

local motionx = 0
local motiony = 4
local motiony2 = 1
local motiony3= 5
local motiony4 = 6
local motiony5 = 3
local motiony6 = 9
local SPEED = 6.5
local LINEAR_VELOCITY = -100
local GRAVITY = 11

local leftW 
local topW
local floor
local rightW

local acorn1
local acorn2
local acorn3
local theAcorn

local muteButton
local unmuteButton 

local questionsAnswered = 0


-----------------------------------------------------------------------------------------
-- SOUNDS
-----------------------------------------------------------------------------------------

local springSound = audio.loadSound("Sounds/dieSound.mp3")
local springSoundChannel 
local backgroundMusic = audio.loadStream("Sounds/backgroundMusic.mp3")
local backgroundMusicChannel

-----------------------------------------------------------------------------------------
-- LOCAL SCENE FUNCTIONS
----------------------------------------------------------------------------------------- 
 
-- When right arrow is touched, move squirrel right
local function right (touch)
    motionx = SPEED
    squirrel.xScale = -1
end

-- When up arrow is touched, add vertical so it can jump
local function up (touch)
    if (squirrel ~= nil) then
        squirrel:setLinearVelocity( 0, LINEAR_VELOCITY )
    end
end

-- When left arrow is touched, move charecter left 
local function left (touch)
    motionx = -SPEED 
    squirrel.xScale = 1
end

-- Move squirrel horizontally
local function movePlayer (event)
    squirrel.x = squirrel.x + motionx
end
 
-- Stop squirrel movement when no arrow is pushed
local function stop (event)
    if (event.phase =="ended") then
        motionx = 0
    end
end

local function moveLeafOne()
    leaf1.y = leaf1.y + motiony4
end

local function moveLeafTwo()
    leaf2.y = leaf2.y + motiony    
end

local function moveLeafThree()
    leaf3.y = leaf3.y + motiony3    
end

local function moveLeafFour()
    leaf4.y = leaf4.y + motiony5    
end

local function moveLeafFive()
    leaf5.y = leaf5.y + motiony2    
end

local function moveLeafSix()
    leaf6.y = leaf6.y + motiony6   
end

local function AddArrowEventListeners()
    rArrow:addEventListener("touch", right)
    uArrow:addEventListener("touch", up)
    lArrow:addEventListener("touch", left)
end

local function RemoveArrowEventListeners()
    rArrow:removeEventListener("touch", right)
    uArrow:removeEventListener("touch", up)
    lArrow:removeEventListener("touch", left)
end

local function AddRuntimeListeners()
    Runtime:addEventListener("enterFrame", movePlayer)
    Runtime:addEventListener("enterFrame", moveLeafOne)
    Runtime:addEventListener("enterFrame", moveLeafTwo)
    Runtime:addEventListener("enterFrame", moveLeafThree)
    Runtime:addEventListener("enterFrame", moveLeafFour)
    Runtime:addEventListener("enterFrame", moveLeafFive)
    Runtime:addEventListener("enterFrame", moveLeafSix)
    Runtime:addEventListener("touch", stop )
end

local function RemoveRuntimeListeners()
    Runtime:removeEventListener("enterFrame", movePlayer)
    Runtime:removeEventListener("enterFrame", moveLeafOne)
    Runtime:removeEventListener("enterFrame", moveLeafTwo)
    Runtime:removeEventListener("enterFrame", moveLeafThree)
    Runtime:removeEventListener("enterFrame", moveLeafFour)
    Runtime:removeEventListener("enterFrame", moveLeafFive)
    Runtime:removeEventListener("enterFrame", moveLeafSix)
    Runtime:removeEventListener("touch", stop )
end

local function Mute(touch)
    if(touch.phase == "ended") then 
        -- pause the music 
        audio.pause(backgroundMusicChannel)

        -- turn the sound variable off 
        soundOn = false 

        -- make the unmute button invisible and the mute button visible 
        muteButton.isVisible = true
        unmuteButton.isVisible = false
    end
end

local function UnMute(touch)
    if(touch.phase == "ended") then 
        -- pause the music 
        audio.resume(backgroundMusicChannel)

        -- turn the sound variable off 
        soundOn = true 

        -- make the unmute button invisible and the mute button visible 
        muteButton.isVisible = false
        unmuteButton.isVisible = true
    end
end

local function AddMuteUnMuteListeners()
    unmuteButton:addEventListener("touch", Mute)
    muteButton:addEventListener("touch", UnMute)

end

local function RemoveMuteUnMuteListeners()
    unmuteButton:removeEventListener("touch", Mute)
    muteButton:addEventListener("touch", UnMute)
end



local function ReplaceSquirrel()
    squirrel = display.newImageRect("Images/squirrelRight.png", 100, 150)
    squirrel.x = 150 
    squirrel.y = 680
    squirrel.width = 90
    squirrel.height = 100
    squirrel:scale( -1, 1 )
    squirrel.myName = "squirrel"

    -- intialize horizontal movement of squirrel
    motionx = 0

    -- add physics body
    physics.addBody( squirrel, "dynamic", { density=0, friction=0.5, bounce=0, rotation=0,} )

    -- prevent squirrel from being able to tip over
    squirrel.isFixedRotation = true

    -- add back arrow listeners
    AddArrowEventListeners()

    -- add back runtime listeners
    AddRuntimeListeners()
end

local function MakeAcornsVisible()
    acorn1.isVisible = true
    acorn2.isVisible = true
    acorn3.isVisible = true 
end

local function MakeHeartsVisible()
    heart1.isVisible = true
    heart2.isVisible = true
    heart3.isVisible = true
end

local function YouLoseTransition()
    composer.gotoScene( "you_lose" )
end

local function YouWinTransition()
    composer.gotoScene( "you_win" )
end

local function onCollision( self, event )
    -- for testing purposes
    --print( event.target )        --the first object in the collision
    --print( event.other )         --the second object in the collision
    --print( event.selfElement )   --the element (number) of the first object which was hit in the collision
    --print( event.otherElement )  --the element (number) of the second object which was hit in the collision
    --print( event.target.myName .. ": collision began with " .. event.other.myName )

    if ( event.phase == "began" ) then

                --Pop sound
        popSoundChannel = audio.play(popSound)

        if  (event.target.myName == "fence1") or 
            (event.target.myName == "fence2") or
            (event.target.myName == "fence3") then

                if (soundOn == true) then 

                    -- play sound effect 
                    springSoundChannel = audio.play( springSound, {channel = 4, loops = 1} )
                end

            -- remove runtime listeners that move the character
            RemoveArrowEventListeners()
            RemoveRuntimeListeners()

            -- remove the character from the display
            display.remove(squirrel)

            -- decrease number of lives
            numLives = numLives - 1

            if (numLives == 2) then
                -- update hearts
                heart1.isVisible = false
                heart2.isVisible = true
                heart3.isVisible = true
                timer.performWithDelay(200, ReplaceSquirrel) 

            elseif (numLives == 1) then
                -- update hearts
                heart1.isVisible = false
                heart2.isVisible = false
                heart3.isVisible = true
                timer.performWithDelay(200, ReplaceSquirrel)

            elseif (numLives == 0) then
                -- update hearts
                heart1.isVisible = false
                heart2.isVisible = false
                heart3.isVisible = false
                timer.performWithDelay(200, YouLoseTransition)
            end
        end

        if  (event.target.myName == "acorn1") or
            (event.target.myName == "acorn2") or
            (event.target.myName == "acorn3") then

            -- get the acorn that the user hit
            theAcorn = event.target

            -- stop the squirrel from moving
            motionx = 0

            -- make the squirrel invisible
            squirrel.isVisible = false

            -- show overlay with math question
            composer.showOverlay( "level1_question", { isModal = true, effect = "fade", time = 100})

            -- Increment questions answered
            questionsAnswered = questionsAnswered + 1
        end

        if (event.target.myName == "door") then
            --check to see if the user has answered 3 questions
            if (questionsAnswered == 3) then
                -- after getting 3 questions right, go to the you win screen

            timer.performWithDelay(200, YouWinTransition)
            end
        end        

    end
end


local function AddCollisionListeners()
    -- if squirrel collides with acorn, onCollision will be called 
    fence1.collision = onCollision
    fence1:addEventListener( "collision" )
    fence2.collision = onCollision
    fence2:addEventListener( "collision" )
    fence3.collision = onCollision
    fence3:addEventListener( "collision" ) 

    acorn1.collision = onCollision
    acorn1:addEventListener( "collision" )
    acorn2.collision = onCollision
    acorn2:addEventListener( "collision" )
    acorn3.collision = onCollision
    acorn3:addEventListener( "collision" )

    door.collision = onCollision
    door:addEventListener( "collision" )
end

local function RemoveCollisionListeners()
    fence1:removeEventListener( "collision" )
    fence2:removeEventListener( "collision" )
    fence3:removeEventListener( "collision" )

    acorn1:removeEventListener( "collision" )
    acorn2:removeEventListener( "collision" )
    acorn3:removeEventListener( "collision" )

    door:removeEventListener( "collision")
end

local function AddPhysicsBodies()
    --add to the physics engine
    physics.addBody( platform1, "static", { density=1.0, friction=0.3, bounce=0.2 } )
    physics.addBody( platform2, "static", { density=1.0, friction=0.3, bounce=0.2 } )
    physics.addBody( platform3, "static", { density=1.0, friction=0.3, bounce=0.2 } )   
    physics.addBody( platform4, "static", { density=1.0, friction=0.3, bounce=0.2 } )
    physics.addBody( platform5, "static", { density=1.0, friction=0.3, bounce=0.2 } )
    physics.addBody( platform6, "static", { density=1.0, friction=0.3, bounce=0.2 } ) 

    physics.addBody( fence1, "static", { density=1.0, friction=0.3, bounce=0.2 } )
    physics.addBody( fence2, "static", { density=1.0, friction=0.3, bounce=0.2 } )
    physics.addBody( fence3, "static", { density=1.0, friction=0.3, bounce=0.2 } ) 

    physics.addBody(leftW, "static", {density=1, friction=0.3, bounce=0.2} )
    physics.addBody(topW, "static", {density=1, friction=0.3, bounce=0.2} )
    physics.addBody(floor, "static", {density=1, friction=0.3, bounce=0.2} )
    physics.addBody(rightW, "static", {density=1, friction=0.3, bounce=0.2} )

    physics.addBody(acorn1, "static",  {density=0, friction=0, bounce=0} )
    physics.addBody(acorn2, "static",  {density=0, friction=0, bounce=0} )
    physics.addBody(acorn3, "static",  {density=0, friction=0, bounce=0} )

    physics.addBody(door, "static", {density=1, friction=0.3, bounce=0.2})
end

local function RemovePhysicsBodies()
    physics.removeBody(platform1)
    physics.removeBody(platform2)
    physics.removeBody(platform3)
    physics.removeBody(platform4)
    physics.removeBody(platform5)
    physics.removeBody(platform6)

    physics.removeBody(fence1)
    physics.removeBody(fence2)
    physics.removeBody(fence3)

    physics.removeBody(leftW)
    physics.removeBody(topW)
    physics.removeBody(floor)
    physics.removeBody(rightW)

    physics.removeBody(door) 
end

-----------------------------------------------------------------------------------------
-- GLOBAL FUNCTIONS
-----------------------------------------------------------------------------------------

function ResumeGame()

    -- make squirrel visible again
    squirrel.isVisible = true
    
    if (questionsAnswered > 0) then
        if (theAcorn ~= nil) and (theAcorn.isBodyActive == true) then
            physics.removeBody(theAcorn)
            theAcorn.isVisible = false
        end
    end

end

-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -- Insert the background image
    bkg_image = display.newImageRect("Images/forest.png", display.contentWidth, display.contentHeight)
    bkg_image.x = display.contentWidth / 2 
    bkg_image.y = display.contentHeight / 2

    -- Insert background image into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( bkg_image )  

    fence1 = display.newImageRect("Images/fenceRight.png", 90, 140)
    fence1.x = 670
    fence1.y = 90
    fence1.myName = "fence1"

    sceneGroup:insert( fence1 )

    fence2 = display.newImageRect("Images/fence.png", 260, 56)
    fence2.x = 595
    fence2.y = 690
    fence2.myName = "fence2"

    sceneGroup:insert( fence2 )

    fence3 = display.newImageRect("Images/fenceDown.png", 298, 66)
    fence3.x = 140
    fence3.y = 340
    fence3.myName = "fence3"

    sceneGroup:insert( fence3 )  
    
    -- Insert the platforms
    platform1 = display.newImageRect("Images/platform1.png", 250, 50)
    platform1.x = display.contentWidth * 1 / 8
    platform1.y = display.contentHeight * 1.6 / 4
        
    sceneGroup:insert( platform1 )

    platform2 = display.newImageRect("Images/platform1.png", 150, 50)
    platform2.x = display.contentWidth * 4.3/5
    platform2.width = 320
    platform2.height = 50
    platform2.y = display.contentHeight * 3.3 / 5
        
    sceneGroup:insert( platform2 )    

    platform3 = display.newImageRect("Images/platform1.png", 180, 50)
    platform3.x = display.contentWidth *4.7 / 5
    platform3.y = display.contentHeight * 1.3 / 5
        
    sceneGroup:insert( platform3 )

    platform4 = display.newImageRect("Images/platform2.png", 50, 150)
    platform4.x = display.contentWidth * 5 / 8
    platform4.height = 300
    platform4.y = display.contentHeight * 0.4 / 5
        
    sceneGroup:insert( platform4)


    platform5 = display.newImageRect("Images/platform1.png", 250, 50)
    platform5.x = display.contentWidth * 1.5 / 8
    platform5.y = display.contentHeight * 3.5 / 5
        
    sceneGroup:insert( platform5 )


    platform6 = display.newImageRect("Images/platform1.png", 150, 50)
    platform6.x = 512
    platform6.width = 1024
    platform6.height = 40
    platform6.y = 700
        
    sceneGroup:insert( platform6 )

    -- Insert the Door
    door = display.newImage("Images/door.png", 200, 200)
    door.x = display.contentWidth*7.17/8 
    door.y = display.contentHeight/1.93
    door.width = 210
    door.height = 180
    door.myName = "door"

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( door )

    -- Insert the Hearts
    heart1 = display.newImageRect("Images/heart2.png", 50, 50)
    heart1.x = 50
    heart1.y = 50
    heart1.isVisible = true

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( heart1 )

    heart2 = display.newImageRect("Images/heart2.png", 50, 50)
    heart2.x = 110
    heart2.y = 50
    heart2.isVisible = true

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( heart2 )

    heart3 = display.newImageRect("Images/heart2.png", 50, 50)
    heart3.x = 170
    heart3.y = 50
    heart3.isVisible = true

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( heart3 )


    --Insert the right arrow
    rArrow = display.newImageRect("Images/rightArrow.png", 100, 50)
    rArrow.x = display.contentWidth * 9.2 / 10
    rArrow.width = 200 
    rArrow.height = 180
    rArrow.y = display.contentHeight * 9.5 / 10
   
    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( rArrow)

    --Insert the up arrow
    uArrow = display.newImageRect("Images/upArrow.png", 50, 100)
    uArrow.x = display.contentWidth * 8.2 / 10
    uArrow.width = 230
    uArrow.height = 180
    uArrow.y = display.contentHeight * 8.5 / 10

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( uArrow)

    --Insert the left arrow
    lArrow = display.newImageRect("Images/leftArrow.png", 100, 50)
    lArrow.x = display.contentWidth * 7.2 / 10
    lArrow.width = 200 
    lArrow.height = 180
    lArrow.y = display.contentHeight * 9.5 / 10

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( lArrow)

    --WALLS--
    leftW = display.newLine( 0, 0, 0, display.contentHeight)
    leftW.isVisible = true

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( leftW )

    rightW = display.newLine( 0, 0, 0, display.contentHeight)
    rightW.x = display.contentCenterX * 2
    rightW.isVisible = true

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( rightW )

    topW = display.newLine( 0, 0, display.contentWidth, 0)
    topW.isVisible = true

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( topW )

    floor = display.newImageRect("Images/Level-1Floor.png", 1024, 100)
    floor.x = display.contentCenterX
    floor.y = display.contentHeight * 1.06
    
    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( floor )

    --acorn1
    acorn1 = display.newImageRect ("Images/acorn.png", 70, 70)
    acorn1.x = 955
    acorn1.y = 140
    acorn1.myName = "acorn1"

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( acorn1 )

    --acorn2
    acorn2 = display.newImageRect ("Images/acorn.png", 70, 70)
    acorn2.x = 230
    acorn2.y = 480
    acorn2.myName = "acorn2"

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( acorn2 )

    --acorn3
    acorn3 = display.newImageRect ("Images/acorn.png", 70, 70)
    acorn3.x = display.contentWidth * 0.5 / 8
    acorn3.y = display.contentHeight  * .98 / 3
    acorn3.myName = "acorn3"

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( acorn3 )

    -- mute button 
    muteButton = display.newImageRect ("Images/muteButton.png", 70, 70)
    muteButton.x = 50 
    muteButton.y = 730
    muteButton.isVisible = false

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( muteButton )

    -- unmute Button 
    unmuteButton = display.newImageRect ("Images/unmuteButton.png", 70, 70)
    unmuteButton.x = 50 
    unmuteButton.y = 730
    unmuteButton.isVisible = true

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( unmuteButton )

    leaf1 = display.newImageRect ("Images/leaf1.png", 80, 80)
    leaf1.x = 350
    leaf1.y = 0
    leaf1.myName = "leaf1"

    leaf2 = display.newImageRect ("Images/leaf1.png", 80, 80)
    leaf2.x = 260
    leaf2.y = 0
    leaf2.myName = "leaf2"

    leaf3 = display.newImageRect ("Images/leaf1.png", 80, 80)
    leaf3.x = 785
    leaf3.y = 0
    leaf3.myName = "leaf3"


    leaf4 = display.newImageRect ("Images/leaf1.png", 80, 80)
    leaf4.x = 480
    leaf4.y = 0
    leaf4.myName = "leaf4"

    leaf5 = display.newImageRect ("Images/leaf1.png", 80, 80)
    leaf5.x = 220
    leaf5.y = 0
    leaf5.myName = "leaf5"

    leaf6 = display.newImageRect ("Images/leaf1.png", 80, 80)
    leaf6.x = 800
    leaf6.y = 0
    leaf6.myName = "leaf6"

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( leaf1 )
    sceneGroup:insert( leaf2 )
    sceneGroup:insert( leaf3 )
    sceneGroup:insert( leaf4 )
    sceneGroup:insert( leaf5 )
    sceneGroup:insert( leaf6 )


end --function scene:create( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to appear on screen
function scene:show( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view
    local phase = event.phase

    -----------------------------------------------------------------------------------------

    if ( phase == "will" ) then

        -- Called when the scene is still off screen (but is about to come on screen).
    -----------------------------------------------------------------------------------------
        -- start physics
        physics.start()

        -- set gravity
        physics.setGravity( 0, GRAVITY )

    elseif ( phase == "did" ) then

        -- Called when the scene is now on screen.
        -- Insert code here to make the scene come alive.
        -- Example: start timers, begin animation, play audio, etc.

        numLives = 3
        questionsAnswered = 0

        if (soundOn == true) then 
            -- play backgroundMusic 
            backgroundMusicChannel = audio.play( backgroundMusic, {channel = 1, loops = -1})
            
            muteButton.isVisible = false
            unmuteButton.isVisible = true 
        else

        end

        -- make all  acorns visible
        MakeAcornsVisible()

        -- make all lives visible
        MakeHeartsVisible()

        -- add physics bodies to each object
        AddPhysicsBodies()

        -- add collision listeners to objects
        AddCollisionListeners()

        -- create the squirrel, add physics bodies and runtime listeners
        ReplaceSquirrel()

        -- add the mute an unmute functionality to the buttons 
        AddMuteUnMuteListeners()

    end

end --function scene:show( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to leave the screen
function scene:hide( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view
    local phase = event.phase

    -----------------------------------------------------------------------------------------

    if ( phase == "will" ) then
        -- Called when the scene is on screen (but is about to go off screen).
        -- Insert code here to "pause" the scene.
        -- Example: stop timers, stop animation, stop audio, etc.

    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then
        -- stop the background music 
        audio.stop(backgroundMusicChannel)

        -- Called immediately after scene goes off screen.
        RemoveCollisionListeners()
        RemovePhysicsBodies()

        physics.stop()
        RemoveArrowEventListeners()
        RemoveRuntimeListeners()
        RemoveMuteUnMuteListeners()
        display.remove(squirrel)
    end

end --function scene:hide( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to be destroyed
function scene:destroy( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------

    -- Called prior to the removal of scene's view ("sceneGroup").
    -- Insert code here to clean up the scene.
    -- Example: remove display objects, save state, etc.

end -- function scene:destroy( event )

-----------------------------------------------------------------------------------------
-- EVENT LISTENERS
-----------------------------------------------------------------------------------------

-- Adding Event Listeners
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene
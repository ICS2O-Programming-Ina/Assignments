-----------------------------------------------------------------------------------------
--
-- splash_screen.lua
-- Created by: Ina
-- Date: May 25, 2020
-- Description: This is the splash screen of the game. It animates parts of my 
-- company logo to come together on the screen. 
-----------------------------------------------------------------------------------------

-- Use Composer Library
local composer = require( "composer" )

-- Name the Scene
sceneName = "splash_screen"

-----------------------------------------------------------------------------------------

-- Create Scene Object
local scene = composer.newScene( sceneName )

----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------
 
-- The local variables for this scene
local scrollXSpeed = 1.2
local scrollYSpeed = -1.7
local scrollXSpeed2 = 3.9

local background 
local flower
local logoText 
local deer 



----------------------------------------------------------------------------------------
-- SOUNDS
-----------------------------------------------------------------------------------------
local backgroundMusic = audio.loadSound("Sounds/bkgMusic.mp3")
local backgroundMusicSoundsChannel

--------------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
--------------------------------------------------------------------------------------------

-- The function that will make the deer move halfway across the screen 
local function moveDeer() 
    deer.x = deer.x + scrollXSpeed
    deer.y = deer.y + scrollYSpeed
    deer.alpha = deer.alpha + 0.01 
    deer.xScale = deer.xScale + .002
end

local function rockFlower()
    if ( reverse == 0 ) then 
        reverse = 1 
        transition.to( flower, { rotation = -90, time = 900, transition = easing.inOutCubic } )
    else
        reverse = 0 
        transition.to ( flower, { rotation = 90, time = 900, transition = easing.inOutCubic } )
    end
end

timer.performWithDelay( 600, rockFlower, 0 )


local function moveFlower()
    flower.x = flower.x - scrollXSpeed2
end

local function moveText()
    logoText.alpha = logoText.alpha + 0.0079
end

-- The function that will go to the main menu 
local function gotoMainMenu()
    composer.gotoScene( "main_menu", {effect = "fade", time = 800} )
end


-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -- Insert the background image
    background = display.newImageRect("Images/background.png", 1024, 768)
    background.anchorX = 0
    background.anchorY = 0

    -- Insert the deer image and set its intial x and y position 
    deer = display.newImageRect("Images/deer.png", 890, 690)
    deer.x = 310 
    deer.y = 700
    deer.alpha = 0 
    deer.xScale = .5

    -- Insert the flower image set its intial x and y position 
    flower = display.newImageRect("Images/flower2.png", 720, 620)
    flower.x = 980 
    flower.y = 490

    -- Insert the logo text image and set its initial x and y position 
    logoText = display.newImageRect("Images/text.png", 200, 65)
    logoText.x = 655
    logoText.y = 380
    logoText.alpha = 0 

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( background )

    -- Insert objects into the scene group in order to ONLY be associated with this scene 
    sceneGroup:insert( deer )

    -- Insert obejcts into the scene group in order to ONLY be associated with this scene 
    sceneGroup:insert( flower )

    sceneGroup:insert( logoText )

end -- function scene:create( event )

--------------------------------------------------------------------------------------------

-- The function called when the scene is issued to appear on screen
function scene:show( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------

    local phase = event.phase

    -----------------------------------------------------------------------------------------

    -- Called when the scene is still off screen (but is about to come on screen).
    if ( phase == "will" ) then
       
    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then
        -- start the splash screen music
        backgroundMusicChannel = audio.play( backgroundMusic )

        -- Call the moveDeer function as soon as we enter the frame.
        Runtime:addEventListener("enterFrame", moveDeer)

        -- Call the moveFlower function as soon as we enter the frame.
        Runtime:addEventListener("enterFrame", moveFlower)

        -- Call the moveText function as soon as we enter the frame. 
        Runtime:addEventListener("enterFrame", moveText)

        -- Go to the main menu screen after the given time.
        timer.performWithDelay ( 3000, gotoMainMenu)          
        
    end

end --function scene:show( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to leave the screen
function scene:hide( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view
    local phase = event.phase

    -----------------------------------------------------------------------------------------

    -- Called when the scene is on screen (but is about to go off screen).
    -- Insert code here to "pause" the scene.
    -- Example: stop timers, stop animation, stop audio, etc.
    if ( phase == "will" ) then  

    -----------------------------------------------------------------------------------------

    -- Called immediately after scene goes off screen.
    elseif ( phase == "did" ) then
        
        -- stop the jungle sounds channel for this screen
        audio.stop(backgroundMusicChannel)
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






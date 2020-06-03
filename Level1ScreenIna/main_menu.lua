-----------------------------------------------------------------------------------------
--
-- main_menu.lua
-- Created by: Ina
-- Date: April 17, 2020
-- Description: This is the main menu, displaying the credits, instructions & play buttons.
-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
-- INITIALIZATIONS
-----------------------------------------------------------------------------------------

-- Use Composer Library
local composer = require( "composer" )

-----------------------------------------------------------------------------------------

-- Use Widget Library
local widget = require( "widget" )

-----------------------------------------------------------------------------------------

-- Naming Scene
sceneName = "main_menu"

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

local bkg_image
local playButton
local creditsButton
local instructionsButton 
local backgroundMusic = audio.loadSound("Sounds/menuSound.mp3")
local backgroundMusicChannel
local muteButton
local unmuteButton

-----------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
-----------------------------------------------------------------------------------------

-- Creating Transition Function to Credits Page
local function CreditsTransition( )       
    composer.gotoScene( "credits_screen", {effect = "slideUp", time = 500})
end 

-----------------------------------------------------------------------------------------

-- Creating Transition to Level1 Screen
local function Level1ScreenTransition( )
    composer.gotoScene( "level1_screen", {effect = "zoomInOutRotate", time = 1000})
end    

-----------------------------------------------------------------------------------------

-- Creating Transition Function to Instructions Page
local function InstructionsTransition( )
    composer.gotoScene( "instructions_screen", {effect = "slideDown", time = 500})
end

-----------------------------------------------------------------------------------------

local function Mute(touch)
    if(touch.phase == "ended") then 
        -- pause the music 
        audio.pause(backgroundMusicChannel)

        -- turn the sound varaiable off 
        soundOn = false 

        -- make the unmute button invisible and the mute button visible 
        muteButton.isVisible = true 
        unmuteButton.isVisible = false
    end
end

-----------------------------------------------------------------------------------------

local function UnMute(touch)
    if(touch.phase == "ended") then 
        -- play the background music 
        audio.resume(backgroundMusicChannel)

        -- turn the sound variable on 
        soundOn = true 

        -- make the unmute button visible and the mute invisible
        muteButton.isVisible = false
        unmuteButton.isVisible = true
    end
end

-----------------------------------------------------------------------------------------

local function AddMuteUnMuteListeners()
    unmuteButton:addEventListener("touch", Mute)
    muteButton:addEventListener("touch", UnMute)
end

local function RemoveMuteUnMuteListeners()
    unmuteButton:removeEventListener("touch", Mute)
    muteButton:removeEventListener("touch", UnMute)
end

-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------
    -- BACKGROUND IMAGE & STATIC OBJECTS
    -----------------------------------------------------------------------------------------

    -- Insert the background image and set it to the center of the screen
    bkg_image = display.newImage("Images/MAINMENU.png")
    bkg_image.x = display.contentCenterX
    bkg_image.y = display.contentCenterY
    bkg_image.width = display.contentWidth
    bkg_image.height = display.contentHeight


    -- Associating display objects with this scene 
    sceneGroup:insert( bkg_image )

    -- Send the background image to the back layer so all other objects can be on top
    bkg_image:toBack()

    -----------------------------------------------------------------------------------------
    -- BUTTON WIDGETS
    -----------------------------------------------------------------------------------------   

    -- Creating Play Button
    playButton = widget.newButton( 
        {   
            -- Set its position on the screen relative to the screen size
            x = display.contentWidth/2,
            y = display.contentHeight*5/8,

            width = 350,
            height = 220,

            -- Insert the images here
            defaultFile = "Images/startButton.png",
            overFile = "Images/startButtonPressed.png",

            -- When the button is released, call the Level1 screen transition function
            onRelease = Level1ScreenTransition          
        } )

    -----------------------------------------------------------------------------------------

    -- Creating Credits Button
    creditsButton = widget.newButton( 
        {
            -- Set its position on the screen relative to the screen size
            x = display.contentWidth*6.4/8,
            y = display.contentHeight*6.5/8,
        

            -- Insert the images here
            defaultFile = "Images/creditsButton.png",
            overFile = "Images/creditsButtonPressed.png",

            -- When the button is released, call the Credits transition function
            onRelease = CreditsTransition
        } ) 

    -----------------------------------------------------------------------------------------

    -- Creating Instructions Button 
    instructionsButton = widget.newButton( 
        { 
            -- Set its position on the screen relative to the screen size 
            x = display.contentWidth*1.5/8,
            y = display.contentHeight*6.5/8,
            

            -- Inset the images here 
            defaultFile = "Images/instructionsButton2.png", 
            overFile = "Images/instructionsButton2Pressed.png", 

            -- When the button is released, call the Instuctions transition function
            onRelease = InstructionsTransition
        } )

    -----------------------------------------------------------------------------------------

    -- Creating the Mute Button
    muteButton = display.newImageRect("Images/muteButton.png", 70, 70)
    muteButton.x = 50
    muteButton.y = 36
    muteButton.isVisible = false

    -----------------------------------------------------------------------------------------

    -- Creating the Unmute Button 
    unmuteButton = display.newImageRect("Images/unmuteButton.png", 70, 70)
    unmuteButton.x = 50
    unmuteButton.y = 36
    unmuteButton.isVisible = true

    -----------------------------------------------------------------------------------------
    -- Associating button widgets with this scene
    sceneGroup:insert( playButton )
    sceneGroup:insert( creditsButton )
    sceneGroup:insert( instructionsButton )
    sceneGroup:insert( muteButton)
    sceneGroup:insert( unmuteButton)

end -- function scene:create( event )   



-----------------------------------------------------------------------------------------

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

    -- Called when the scene is now on screen.
    -- Insert code here to make the scene come alive.
    -- Example: start timers, begin animation, play audio, etc.
    elseif ( phase == "did" ) then    

        if (soundOn == true) then 
            -- play background music 
            backgroundMusicChannel = audio.play( backgroundMusic, {channel = 1, loops = -1} )

            muteButton.isVisible = false 
            unmuteButton.isVisible = true
        else

        end

        -- add the mute and unmute functionality to the buttons 
        AddMuteUnMuteListeners()
    end

end -- function scene:show( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to leave the screen
function scene:hide( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------

    local phase = event.phase

    -----------------------------------------------------------------------------------------

    if ( phase == "will" ) then
        -- Called when the scene is on screen (but is about to go off screen).
        -- Insert code here to "pause" the scene.
        -- Example: stop timers, stop animation, stop audio, etc.

    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then
        -- Called immediately after scene goes off screen.
        -- Stop background music for this screen 
        audio.stop(backgroundMusicChannel)
        RemoveMuteUnMuteListeners()
    end

end -- function scene:hide( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to be destroyed
function scene:destroy( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

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

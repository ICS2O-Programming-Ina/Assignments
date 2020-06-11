-----------------------------------------------------------------------------------------
--
-- character_select.lua
-- Created by: Ina 
-- Date: June 10, 2020 
-- Description: This is the character selection page, displaying three characters to choose from 
-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
-- INITIALIZATIONS
-----------------------------------------------------------------------------------------

-- Use Composer Libraries
local composer = require( "composer" )
local widget = require( "widget" )

-----------------------------------------------------------------------------------------

-- Naming Scene
sceneName = "character_select"

-- Creating Scene Object
scene = composer.newScene( sceneName ) -- This function doesn't accept a string, only a variable containing a string

-----------------------------------------------------------------------------------------
-- SOUNDS
-----------------------------------------------------------------------------------------
local backgroundMusic = audio.loadSound("Sounds/backgroundMusic.mp3")
local backgroundMusicChannel

-----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------
local bkg_image
local backButton
local dogButton 
local squirrelButton 
local catButton 
local characterText

-----------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
-----------------------------------------------------------------------------------------

-- Creating Transitioning Function back to main menu
local function BackTransition( )
    composer.gotoScene( "main_menu", {effect = "slideUp", time = 500})
end

-- Creating Transitioning Function to the level1_dog
local function DogScreenTransition( )
    composer.gotoScene( "level1_dog", {effect = "slideUp", time = 500})
end

-- Creating Transitioning Function to the level1_screen
local function SquirrelScreenTransition( )
    composer.gotoScene( "level1_squirrel", {effect = "slideUp", time = 500})
end

-- Creating Transitioning Function to the level1_cat
local function CatScreenTransition( )
    composer.gotoScene( "level1_cat", {effect = "slideUp", time = 500})
end


-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------
    -- BACKGROUND AND DISPLAY OBJECTS
    -----------------------------------------------------------------------------------------

    -- Insert the background image and set it to the center of the screen
    bkg_image = display.newImageRect("Images/grey.png", display.contentWidth, display.contentHeight)
    bkg_image.x = display.contentCenterX
    bkg_image.y = display.contentCenterY
    bkg_image.width = display.contentWidth
    bkg_image.height = display.contentHeight

    -- Associating display objects with this scene 
    sceneGroup:insert( bkg_image )

    -- Send the background image to the back layer so all other objects can be on top
    bkg_image:toBack()

    -- Insert the character text and set its position on the screen
    characterText = display.newImageRect("Images/characterText.png", 600, 400 )
    characterText.x = 800
    characterText.y = 100

    -- Associating display objects with this scene 
    sceneGroup:insert( characterText )

    -----------------------------------------------------------------------------------------
    -- BUTTON WIDGETS
    -----------------------------------------------------------------------------------------

    -- Creating Back Button
    backButton = widget.newButton( 
    {
        -- Setting Position
        x = display.contentWidth*1.5/8,
        y = display.contentHeight*14.6/16,
    

        -- Setting Dimensions
        -- width = 1000,
        -- height = 106,

        -- Setting Visual Properties
        defaultFile = "Images/backButton.png",
        overFile = "Images/backButtonPressed.png",

        -- Setting Functional Properties
        onRelease = BackTransition

    } )


    -- Creating Dog Button
    dogButton = widget.newButton( 
    {
        -- Setting Position
        x = 240,
        y = display.contentHeight/6,
    

        -- Setting Dimensions
        -- width = 1000,
        -- height = 106,

        -- Setting Visual Properties
        defaultFile = "Images/dogButton.png",
        overFile = "Images/dogButtonPressed.png",

        -- Setting Functional Properties
        onRelease = DogScreenTransition

    } )


    -- Creating Squirrel Button
    squirrelButton = widget.newButton( 
    {
        -- Setting Position
        x = 520, 
        y = display.contentHeight/2,
    

        -- Setting Dimensions
        -- width = 1000,
        -- height = 106,

        -- Setting Visual Properties
        defaultFile = "Images/squirrelButton.png",
        overFile = "Images/squirrelButtonPressed.png",

        -- Setting Functional Properties
        onRelease = SquirrelScreenTransition

    } )


    -- Creating Cat Button
    catButton = widget.newButton( 
    {
        -- Setting Position
        x = 800,
        y = 640,
    

        -- Setting Dimensions
        -- width = 1000,
        -- height = 106,

        -- Setting Visual Properties
        defaultFile = "Images/catButton.png",
        overFile = "Images/catButtonPressed.png",

        -- Setting Functional Properties
        onRelease = CatScreenTransition

    } )

    -----------------------------------------------------------------------------------------

    -- Associating Buttons with this scene
    sceneGroup:insert( backButton )
    sceneGroup:insert( dogButton )
    sceneGroup:insert( squirrelButton )
    sceneGroup:insert( catButton )
    
end --function scene:create( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to appear on screen
function scene:show( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------

    local phase = event.phase

    -----------------------------------------------------------------------------------------

    if ( phase == "will" ) then
        -- Called when the scene is still off screen (but is about to come on screen).

    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then
        -- Called when the scene is now on screen.
        -- Insert code here to make the scene come alive.
        -- Example: start timers, begin animation, play audio, etc.
        if (soundOn == true) then 
            -- play background music 
            backgroundMusicChannel = audio.play( backgroundMusic, {channel = 3, loops = -1} )

        else

        end
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

end --function scene:destroy( event )

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




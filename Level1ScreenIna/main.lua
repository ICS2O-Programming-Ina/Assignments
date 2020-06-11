-----------------------------------------------------------------------------------------
--
-- main.lua
-- Created by: Ina
-- Date: May 25, 2020
-- Description: This calls the splash screen of the app to load itself.
-----------------------------------------------------------------------------------------

-- Hide the status bar
display.setStatusBar(display.HiddenStatusBar)

-----------------------------------------------------------------------------------------

-- Use composer library
local composer = require( "composer" )

-----------------------------------------------------------------------------------------

-- Go to the intro screen
composer.gotoScene( "main_menu" )

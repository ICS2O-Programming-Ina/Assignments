-- Title: Animating Images 
-- Name: Ina 
-- Course: ICS2O 
-- This program displays a sunset with a palm tree. It shows a cloud and a sun moving. 

-- hide status bar 
display.setStatusBar(display.HiddenStatusBar)

-- background image with width and height 
local backgroundImage = display.newImageRect("Images/city.jpg", 2045 , 1536)
backgroundImage:scale( 1, 1)

-- local character image with width and height 
local sun = display.newImageRect("Images/sun.png", 200, 200)

-- local character image with a width and height 
local cloud = display.newImageRect("Images/clouds.png", 150, 150)

-- set the image to be transparent 
sun.alpha = 0 

-- set the initial x and y 
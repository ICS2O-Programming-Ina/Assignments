-- Title: Animating Images 
-- Name: Ina 
-- Course: ICS2O 
-- This program displays a sunset with a palm tree. It shows a cloud and a sun moving. 

-- hide status bar 
display.setStatusBar(display.HiddenStatusBar)

-- background image with width and height 
local backgroundImage = display.newImageRect("Images/vancouver.jpeg", 1024, 768)
backgroundImage.x = display.contentCenterX
backgroundImage.y = display.contentCenterY


-- local character image with width and height 
local sun = display.newImageRect("Images/sun.png", 125, 125)

-- local character image with a width and height 
local clouds = display.newImageRect("Images/clouds.png", 350, 350)

-- local character image with a width and height 
local palmTree = display.newImageRect("Images/palmTree.png", 900, 900)

-- set the image to be transparent 
sun.alpha = .8

-- set the initial x and y posititon of the sun
sun.x = 155
sun.y = 75

-- set the initial x and y position of the clouds
clouds.x = 160
clouds.y = 75

-- set the image to be transparent
palmTree.alpha = .9

-- set the initial x and y position of the palm tree 
palmTree.x = 512
palmTree.y = 760

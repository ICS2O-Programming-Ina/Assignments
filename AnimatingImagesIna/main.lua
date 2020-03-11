-- Title: Animating Images 
-- Name: Ina 
-- Course: ICS2O 
-- This program displays a sunset with a palm tree. It shows a cloud and a sun moving. 

-- hide status bar 
display.setStatusBar(display.HiddenStatusBar)

-- global variables 
scrollSpeed = 2
scrollSpeed1 = 5
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

-- local character image with a width and height 
local smallPalmTree = display.newImageRect("Images/palmTree.png", 175, 175)



-- set the image to be transparent 
sun.alpha = .8


-- set the initial x and y posititon of the sun
sun.x = 155
sun.y = 75

-- set the initial x and y position of the clouds
clouds.x = 160
clouds.y = 75

-- set the image to be transparent
clouds.alpha = 1

-- set the initial x and y position of the palm tree 
palmTree.x = 170
palmTree.y = 760

-- set the initial x and y position of the small palm tree 
smallPalmTree.x = 215
smallPalmTree.y = 760

local function rockSun()
	if ( reverse == 0 ) then 
		reverse = 1 
		transition.to( sun, { rotation = -45, time = 500, transition = easing.inOutCubic } )
	else
		reverse = 0 
		transition.to ( sun, { rotation = 45, time = 500, transition = easing.inOutCubic } )
	end
end

timer.performWithDelay( 600, rockSun, 0 )

-- Function: MoveSun 
-- Input: this function accepts an event listener 
-- Output: none
-- Description: This function add the scroll speed to the x-value of the sun 
local function MoveSun(event)
	-- add the scroll speed to the x-value of the sun 
	sun.x = sun.x + scrollSpeed 
	-- change the transparency of the sun every time it moves so that it fades out 
	sun.alpha = sun.alpha + 0.1
	if (sun.x > 1024) then 
		sun.x = 1024 - scrollSpeed1
	end
end

-- MoveSun will be called over and over again 
Runtime:addEventListener("enterFrame", MoveSun)

-- Function: MoveClouds
-- Input: this function accepts an event listener 
-- Output: none
-- Description: This function add the scroll speed to the x-value of the clouds
local function MoveClouds(event)
	-- add the scroll speed to the x-value of the clouds
	clouds.x = clouds.x + scrollSpeed 
	-- change the transparency of the clouds every time it moves so that it fades out 
	clouds.alpha = clouds.alpha - .001
end

-- MoveClouds will be called over and over again 
Runtime:addEventListener("enterFrame", MoveClouds)
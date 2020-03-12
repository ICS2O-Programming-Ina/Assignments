-- Title: Animating Images 
-- Name: Ina 
-- Course: ICS2O 
-- This program displays a sunset with moving, clouds, a sun, and a palm tree. 

-- hide status bar 
display.setStatusBar(display.HiddenStatusBar)

-- global variables 
scrollSpeed = 2
scrollSpeed1 = 3

------------------------------------------------------------------------------------
-- LOCAL VARIABLES 
------------------------------------------------------------------------------------

-- background image with width and height 
local backgroundImage = display.newImageRect("Images/vancouver.jpeg", 1024, 768)
backgroundImage.x = display.contentCenterX
backgroundImage.y = display.contentCenterY

-- local character image with width and height 
local sun = display.newImageRect("Images/sun.png", 125, 125)

-- local character image with a width and height 
local clouds = display.newImageRect("Images/clouds.png", 350, 350)

-- local character image with a width and height 
local palmTree = display.newImageRect("Images/palmTree.png", 500, 500)

-- local character image with a width and height 
local smallPalmTree = display.newImageRect("Images/palmTree.png", 175, 175)
smallPalmTree.isVisible = true

-- local character image with a width and heigth 
local star = display.newImageRect("Images/star.png", 75, 75)

-- local character image with a width and height 
local clearStar = display.newImageRect("Images/clearStar.png", 100, 100)

-- my boolean variable to keep track of when it is first touched 
local alreadyTouchedStar = false
local alreadyTouchedClearStar = false

local backgroundText 
local textSize = 30
local backgroundName = "S    U    N    N    Y        D    A    Y    S"

-- set the images to be transparent 
sun.alpha = .8

clouds.alpha = 1

star.alpha = .6

-- makes the clouds bigger 
clouds:scale(-1.05,1.05)

-- set the initial x and y posititon of the objects
sun.x = 155
sun.y = 75

clouds.x = 160
clouds.y = 75

palmTree.x = 170
palmTree.y = 760
transition.to(palmTree, { x=450, y=-280, time=5000})

smallPalmTree.x = 215
smallPalmTree.y = 760

star.x = 1000
star.y = 340

clearStar.x = 970
clearStar.y = 290

-- make palmTree invisible 
palmTree.isVisible = true

-----------------------------------------------------------------------------------------------------
-- EVENT LISTENERS 
-----------------------------------------------------------------------------------------------------

-- Function: PalmTreeListener 
-- Input: touch listener 
-- Output: none 
-- Description: when the palm tree is clicked, it turns invisible
local function PalmTreeListener(touch)
	if (touch.phase == "began") then 
		palmTree.isVisible = true
		smallPalmTree.isVisible = false
	end
end
-- add the respective listener to the object 
palmTree:addEventListener("touch", PalmTreeListener)

-- Function: StarListener 
-- Input: touch listener 
-- Output: none 
-- Description: when star is touched, move it 
local function StarListener(touch)

	if (touch.phase == "began") then 
		if (alreadyTouchedClearStar == false ) then 
			alreadyTouchedStar = true
		end
	end

	if ( (touch.phase == "moved") and ( alreadyTouchedStar == true) ) then 
		star.x = touch.x
		star.y = touch.y 
	end

	if (touch.phase == "ended") then 
		alreadyTouchedStar = false
	end
end

-- add the respective variable listener to the star
star:addEventListener("touch", StarListener)

-- Function: ClearStarListener 
-- Input: touch listener 
-- Output: none 
-- Description: when clear star is touched, move it 
local function ClearStarListener(touch)

	if (touch.phase == "began") then 
		if (alreadyTouchedStar == false ) then 
			alreadyTouchedClearStar = true

		end
	end

	if ( (touch.phase == "moved") and ( alreadyTouchedClearStar == true) ) then 
		clearStar.x = touch.x
		clearStar.y = touch.y 
	end

	if (touch.phase == "ended") then 
		alreadyTouchedClearStar = false
	end
end

-- add the respective variable listener to the star
clearStar:addEventListener("touch", ClearStarListener)

-----------------------------------------------------------------------------------------------------------------
-- FUNCTIONS 
-----------------------------------------------------------------------------------------------------------------

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
	-- change the transparency of the sun every time it moves so that it fades out 
	sun.alpha = sun.alpha + 0.1
	if (sun.x < 1024 ) then 
		sun.x = sun.x + scrollSpeed + sun.yScale
	elseif (sun.x > 1024) then 
		sun.x = sun.x + scrollSpeed1 and sun:scale(-1,1)
		timer.performWithDelay( 600, rockSun, 0) 
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
	clouds.x = clouds.x - scrollSpeed 
	-- change the transparency of the clouds every time it moves so that it fades out 
	clouds.alpha = clouds.alpha - .001
end

-- MoveClouds will be called over and over again 
Runtime:addEventListener("enterFrame", MoveClouds)

-- write sunny day on the screen. 
backgroundText = display.newText(backgroundName, 0, 0, Arial, textSize)

-- anchor the text and set its (x,y) position 
backgroundText.anchorX = 0
backgroundText.anchorY = 0 
backgroundText.x = 512 
backgroundText.y = 350

backgroundText:setTextColor(220/255, 182/255, 182/255 )



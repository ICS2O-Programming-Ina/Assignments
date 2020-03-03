-- Title: Local Variables 
-- Name: Ina 
-- Course: ICS2O
-- This program displays four different shapes and calculates their areas

-- set the background colour of my screen.Remeber that colors are between 0 and 1. 
display.setDefault("background", 232/255, 218/255, 239,255)

-- to remove status background
display.setStatusBar(display.HiddenStatusBar) 

local verticesTrapezoid = { -70, 70, 70, 70, 160, -70, -160, -70 }
local trapezoid = display.newPolygon(display.contentWidth/4, display.contentHeight/4, verticesTrapezoid)
local myTrapezoid
local verticesTrapezoid = { -100, 100, 100, 100, 190, -100, -190, -100 }
local trapezoid = display.newPolygon( 256, 192, verticesTrapezoid)
local verticesTriangle = { -190, -100, 0, 100, 190, -100 }
local triangle = display.newPolygon( 768, 192, verticesTriangle)
local verticesOctogon = { -60, 150, 60, 150, 150, 60, 150, -60, 60, -150, -60, -150, -150, -60, -150, 60 }
local octogon = display.newPolygon( 256, 574, verticesOctogon)
local verticesStar = { 180, -60, 50, -60, 0, -180, -50, -60, -180, -60, -70, 30, -140, 160, 0, 100, 150, 160, 70, 30 }
local star = display.newPolygon( 768, 574, verticesStar)
local baseOfTriangle = 20
local heightOfTriangle = 55
local areaOfTriangle 
local areaText 
local textSize = 27
local paint = {
	type = "gradient",
	color1 = { 255/255, 236/255, 255/255 },
	color2 = { 225/255, 201/255, 224/255  },
	color3 = { 205/255, 180/255, 203/255 },
	direction = "up"
}
local ombre = { 
	type = "gradient",
	color1 = { 205/255, 180/255, 203/255 },
	color2 = { 251/255, 231/255, 250/255 },
	color3 = { 255/255, 227/255, 254/255 },
	direction = "up"
}
local fade =  { 
	type = "gradient",
	color1 = { 237/255, 214/255, 236/255  },
	color2 = { 233/255, 215/255, 232/255  },
	color3 = { 222/255, 176/255, 219/255 },
	direction = "up"
}
local gradient =  { 
	type = "gradient",
	color1 = { 213/255, 195/255, 212/255 },
	color2 = { 243/255, 222/255, 242/255 },
	color3 = { 232/255, 203/255, 230/255 },
	direction = "up"
}

-- set the width of the border 
trapezoid.storkeWidth = 20
-- set the width of the border
trapezoid.strokeWidth = 10

-- set the colour of the trapezoid 
trapezoid:setFillColor(.8, .7, .8)
trapezoid:setFillColor(paint)

-- set the color of the border
trapezoid:setStrokeColor(1, 1, 1)

-- set the width of the border 
triangle.strokeWidth = 10

-- set the colour of the triangle
triangle:setFillColor(paint)

-- set the color of the border
triangle:setStrokeColor(1, 1, 1)

-- set the width of the border 
octogon.strokeWidth = 10

-- set the colour of the octogon 
octogon:setFillColor(paint)

-- set the color of the border 
octogon:setStrokeColor(1, 1, 1)

-- set the width of the border 
star.strokeWidth = 10

-- set the colour of the star 
star:setFillColor(paint)

-- set the color of the border
star:setStrokeColor(1, 1, 1)

-- calculate the area 
areaOfTriangle = baseOfTriangle * heightOfTriangle / 2 

-- write the area on the screen
areaText = display.newText("The area of this triangle with a base of \n" ..
	baseOfTriangle .. " and a height of " .. heightOfTriangle .. " is " ..
	areaOfTriangle .." pixels².", 0, 0, Arial, textSize)

-- anchor the text and set its (x.y) position 
areaText.anchorX = 0
areaText.anchorY = 0
areaText.x = 525
areaText.y = 310

-- set the colour of the newText
areaText:setTextColor(138/255, 124/255, 124/255)
-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------

-- create local variables 
local questionObject 
local correctObject 
local incorrectObject 
local numericField 
local randomOperator = math.random(1,4)
local randomNumberAddSub1
local randomNumberAddSub2
local randomNumberMult1
local randomNumberMult2 
local randomNumberDiv1 
local randomNumberDiv2 
local userAnswer 
local correctAnswer
local correctAnswer1 
local textSize = 50 
local numberCorrect 

-----------------------------------------------------------------------------------------
-- SOUNDS 
-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
-- FUNCTIONS 
-----------------------------------------------------------------------------------------

local function AskQuestion()
	-- generate 2 random numbers between a max and min for addition and subtraction questions 
	randomNumberAddSub1 = math.random(1,20)
	randomNumberAddSub2 = math.random(1,20)

	-- generate 2 random numbers between a max and min for multiplication questions 
	randomNumberMult1 = math.random(1,10)
	randomNumberMult2 = math.random(1,10)

	-- generate 2 random numbers between a max and min for division questions 
	randomNumberDiv1 = math.random(1,100)
	randomNumberDiv2 = math.random(1,100)

	-- if the random operator is 1, then do addition 
	if (randomOperator == 1) then 
		-- calculate the correct answer 
		correctAnswer = randomNumberAddSub1 + randomNumberAddSub2
		-- create question in text object 
		quesstionObject.text = randomNumberAddSub1 .. " + " .. randomNumberAddSub2 .. " = "

	-- otherwise, if the random operator is 3, do multiplication
	elseif (randomOperator == 3) then 
		-- calculate te correct answer 
		correctAnswer = randomNumberMult1 * randomNumberMult2
		-- create question in the text object 
		questionObject.text = randomNumberMult1 .. " x " .. randomNumberMult2 .. " = "

	-- otherwise, if the random operator is 4, do division 
	elseif (randomOperator == 4) then 
		-- calculate the correct answer 
		correctAnswer1 = randomNumberDiv1 * randomNumberDiv2
		correctAnswer = correctAnswer1 / randomNumberDiv1
		-- create question in text object 
		questionObject.text = correctAnswer1 .. " / " .. randomNumberDiv1 .. " = "

	-- otherwise, if the random operator is 2, do subtraction
	elseif (randomOperator == 2) then 
		-- calculate the correct answer 
		correctAnswer = randomNumberAddSub1 - randomNumberAddSub2 

		if (randomNumberAddSub1 < randomNumberAddSub2) then 
			correctAnswer = randomNumberAddSub2 - randomNumberAddSub1
			-- create question in text object 
			questionObject.text = randomNumberAddSub2 .. " - " .. randomNumberAddSub1 .. " = "
		end
	end
end 

local function HideCorrect()
	correctObject.isVisible = false 
	AskQuestion()
end 

local function HideIncorrect() 
	incorrectObject.isVisible = false 
	AskQuestion()
end

local function NumericFieldListener( event )
	-- user begins editing "numericField"
	if (event.phase == "began") then 
		-- clear text field 
		event.target.text = ""

	elseif event.phase == "submitted" then 
		-- when the answer is submitted(enter key is pressed) set user input to user's answer 
		userAnswer = tonumber(event.target.text)

		if (userAnswer == correctAnswer) then 
			event.target.text = ""
			correctObject.isVisible = true 
			timer.performWithDelay(2100, HideCorrect)
			-- add a point if the user gets the correct answer 
			numberCorrect = numberCorrect + 1 
			-- update it in the display object 
			numberCorrectText.text = "Number Correct = " .. numberCorrect

			if (numberCorrect == 5) then 
				correctObject.isVisible



-----------------------------------------------------------------------------------------
-- Title: MathQuiz
-- Name: Ina
-- Course: ICS2O
-- This program displays a math quiz with 10 seconds per question and three total lives. 
-----------------------------------------------------------------------------------------

-- hide the status bar 
display.setStatusBar(display.HiddenStatusBar)

-- sets the background colour 
display.setDefault("background", 255/255, 153/255, 153/255)

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
local numberCorrect = 0
local actualAnswerText = "The correct answer "
local totalSeconds = 10 
local secondsLeft = 10 
local clockText 
local countDownTimer 
local lives = 3 

local heart1 
local herat2
local heart3

-----------------------------------------------------------------------------------------
-- SOUNDS 
-----------------------------------------------------------------------------------------

local cheerSound = audio.loadSound( "Sounds/cheerSound.mp3" )
local cheerSoundChannel
local gameOverSound = audio.loadSound( "Sounds/gameOverSound.mp3" )
local gameOverSoundChannel

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

	-- resume the background music 
	audio.resume( 1 )

	-- if the random operator is 1, then do addition 
	if (randomOperator == 1) then 
		-- calculate the correct answer 
		correctAnswer = randomNumberAddSub1 + randomNumberAddSub2
		-- create question in text object 
		questionObject.text = randomNumberAddSub1 .. " + " .. randomNumberAddSub2 .. " = "

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

local function HideActualAnswerText()
	actualAnswerText.isVisible = false
end


local function NumericFieldListener( event )
	-- user begins editing "numericField"
	if (event.phase == "began") then 
		-- clear text field 
		event.target.text = ""

	elseif (event.phase == "submitted") then 
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
			cheerSoundChannel = audio.play(cheerSound)
			audio.stop( 1 )
			secondsLeft = totalSeconds

			if (numberCorrect == 5) then 
				correctObject.isVisible = false 
				numberCorrectText.isVisible = false 
				questionObject.isVisible = false 
			end

		else 
			event.target.text = ""
			incorrectObject.isVisible = true 
			timer.performWithDelay(2100, HideIncorrect)
			actualAnswerText.isVisible = true
			timer.performWithDelay(2100, HideActualAnswerText)
			actualAnswerText = display.newText("The correct answer is " .. correctAnswer, 480, 490, nil, 30)
			actualAnswerText:setTextColor(176/255, 179/255, 191/255)
			wrongSoundChannel = audio.play(wrongSound)
			lives = lives - 1
			audio.stop( 1 )
			if (lives == 2) then 
				heart3.isVisible = false 
			elseif (lives == 1) then 
				heart2.isVisible = false 
			elseif (lives == 0) then 
				heart1.isVisible = false 
				numericField.isVisible = false 
				incorrectObject.isVisible = false 
				clockText.isVisible = false 
				questionObject.isVisible = false 
				actualAnswerText.isVisible = false 
				gameOverSoundChannel = audio.play( gameOverSound )
				countDownTimer = timer.cancel( countDownTimer )

			end
			AskQuestion()
		end
	end
end

local function updateTime()

	-- decrement the number of seconds 
	secondsLeft = secondsLeft - 1

	-- display the number of seconds left in the clock object
	clockText.text = secondsLeft .. ""

	if (secondsLeft == 0) then 
		-- reset the number of seconds left 
		secondsLeft = totalSeconds
		lives = lives - 1
		actualAnswerText.isVisible = true
		timer.performWithDelay(2100, HideActualAnswerText)
		actualAnswerText = display.newText("The correct answer is " .. correctAnswer, 480, 490, nil, 30)
		actualAnswerText:setTextColor(176/255, 179/255, 191/255)


		if (lives == 2) then 
			heart3.isVisible = false 
		elseif (lives == 1) then 
			heart2.isVisible = false 
		elseif (lives == 0) then 
			heart1.isVisible = false 
			numericField.isVisible = false 
			incorrectObject.isVisible = false 
			clockText.isVisible = false 
			questionObject.isVisible = false 
			actualAnswerText.isVisible = false
			gameOverSoundChannel = audio.play( gameOverSound )
			countDownTimer = timer.cancel( countDownTimer )
		end
		AskQuestion()
	end
end

-- function that calls the timer 
local function StartTimer()
	-- create a countdown timer that loops infinetly 			
	countDownTimer = timer.performWithDelay( 1000, updateTime, 0)
end

-----------------------------------------------------------------------------------------
-- OBJECT CREATION
-----------------------------------------------------------------------------------------

-- displays a question and sets the colour 
questionObject = display.newText( "", 405, 370, nil, 70, Arial, textSize)
questionObject:setTextColor(250/255, 214/255, 214/255)

-- create the correct text object and make it invisible 
correctObject = display.newText( "Correct!", 480, 460, nil, 50)
correctObject:setTextColor(230/255, 229/255, 229/255)
correctObject.isVisible = false 

-- create the incorrect text object and make it invisible 
incorrectObject = display.newText( "Incorrect", 480, 460, nil, 50)
incorrectObject:setTextColor(230/255, 229/255, 229/255)
incorrectObject.isVisible = false 

-- displays the amount of correct answers as a text object 
numberCorrectText = display.newText( "Number Correct = " .. numberCorrect, 150, 730, nil, 32)
numberCorrectText:setTextColor(161/255, 73/255, 73/255)

-- create numeric field 
numericField = native.newTextField( 590, 370, 150, 90)
numericField.inputType = "number"

-- add the event listener for the numeric field 
numericField:addEventListener( "userInput", NumericFieldListener)

-- create the lives to display on the screen 
heart1 = display.newImageRect("Images/heart.png", 50, 50)
heart1.x = 980 
heart1.y = 70

heart2 = display.newImageRect("Images/heart.png", 50, 50)
heart2.x = 880 
heart2.y = 70

heart3 = display.newImageRect("Images/heart.png", 50, 50)
heart3.x = 780 
heart3.y = 70

-- create the clock text 
clockText = display.newText( secondsLeft, 55, 70, nil, 50, Arial, textSize)
clockText:setTextColor( 255/255, 255/255, 255/255)

-----------------------------------------------------------------------------------------
-- FUNCTION CALLS 
-----------------------------------------------------------------------------------------

-- call the function to ask a question 
AskQuestion()

-- call the function to start the timer 
StartTimer()
























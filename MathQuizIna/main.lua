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

scrollSpeed = 4.5

-----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------

-- create local variables 
local questionObject 
local correctObject 
local incorrectObject 
local numericField 
local randomOperator = math.random(1,6)
local randomNumberAddSub1
local randomNumberAddSub2
local randomNumberMult1
local randomNumberMult2 
local randomNumberDiv1 
local randomNumberDiv2 
local randomNumberPow
local randomNumberPow2
local randomNumerSq
local userAnswer 
local correctAnswer 
local correctAnswer1 
local actualAnswerText
local textSize = 50 
local numberCorrect = 0
local totalSeconds = 10 
local secondsLeft = 10 
local clockText 
local countDownTimer 
local lives = 3 
local totalSeconds2 = 12

local heart1 
local herat2
local heart3
local youWin 
local youLose

-----------------------------------------------------------------------------------------
-- SOUNDS 
-----------------------------------------------------------------------------------------

local cheerSound = audio.loadSound( "Sounds/cheerSound.mp3" )
local cheerSoundChannel
local gameOverSound = audio.loadSound( "Sounds/gameOverSound.mp3" )
local gameOverSoundChannel
local wrongSound = audio.loadSound( "Sounds/wrongSound.mp3" )
local wrongSoundChannel 
local youWinSound = audio.loadSound( "Sounds/youWinSound.mp3" )
local youWinSoundChannel

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
	randomNumberDiv1 = math.random(1,10)
	randomNumberDiv2 = math.random(1,10)

	-- generate a random number between a max and min for exponent questions 
	randomNumberPow2 = math.random(1,3)
	randomNumberPow = math.random(0,10)

	-- generate a random number between a max and min for square root questions 
	randomNumberSq = math.random(2,10)

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

	-- otherwise, if the random operator is 5, use an exponent
	elseif (randomOperator == 5) then 
		-- calculate the correct answer
		correctAnswer = randomNumberPow ^ randomNumberPow2
		-- create question in text object 
		questionObject.text = randomNumberPow .. " ^ " .. randomNumberPow2 .. " = "
	
	-- otherwise, if the random operator is 5, use a square root
	elseif (randomOperator == 6) then 
		-- calculate the correct answer
		correctAnswer1 = randomNumberSq * randomNumberSq
		correctAnswer = math.sqrt(correctAnswer1)
		-- create question in text object 
		questionObject.text = "√" .. correctAnswer1 .. " = "

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
			timer.performWithDelay(2000, HideCorrect)
			-- add a point if the user gets the correct answer 
			numberCorrect = numberCorrect + 1 
			-- update it in the display object 
			numberCorrectText.text = "Number Correct = " .. numberCorrect
			cheerSoundChannel = audio.play(cheerSound)
   			secondsLeft = totalSeconds2

			if (numberCorrect == 5) then 
				correctObject.isVisible = false 
				numberCorrectText.isVisible = false 
				numericField.isVisible = false 
				clockText.isVisible = false 
				questionObject.isVisible = false
				heart1.isVisible = false 
				heart2.isVisible = false 
				heart3.isVisible = false 
				youWin.isVisible = true
				youWinSoundChannel = audio.play( youWinSound )
				countDownTimer = timer.cancel( countDownTimer )
			end

		else 
			event.target.text = ""
			incorrectObject.isVisible = true 
			timer.performWithDelay(2000, HideIncorrect)
			wrongSoundChannel = audio.play( wrongSound )
			lives = lives - 1
			actualAnswerText.text = "The correct answer is " .. correctAnswer
			actualAnswerText.isVisible = true
			timer.performWithDelay(2000, HideActualAnswerText)
			secondsLeft = totalSeconds2
		
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
				numberCorrectText.isVisible = false
				actualAnswerText.isVisible = false
				youLose.isVisible = true
				gameOverSoundChannel = audio.play( gameOverSound )
				countDownTimer = timer.cancel( countDownTimer )
			end
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
		wrongSoundChannel = audio.play( wrongSound )
		actualAnswerText.text = "The correct answer is " .. correctAnswer
		actualAnswerText.isVisible = true
		timer.performWithDelay(2000, HideActualAnswerText)
		secondsLeft = totalSeconds2

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
			gameOverSoundChannel = audio.play( gameOverSound )
			countDownTimer = timer.cancel( countDownTimer )
			numberCorrectText.isVisible = false
			youLose.isVisible = true
		end
		AskQuestion()
	end
end

-- function that calls the timer 
local function StartTimer()
	-- create a countdown timer that loops infinetly 			
	countDownTimer = timer.performWithDelay( 1000, updateTime, 0)
end

-- Function: MoveYouLose
-- Input: this function accepts an event listener
-- Ouput: none 
-- Description: This funtion adds the scroll speed to the x-value of this image
local function MoveYouLose(event)
	-- add the scroll speed to the x-value of this image
	youLose.x = youLose.x + scrollSpeed
	-- change the transparency of the image every time it moves so that it fades out 
	youLose.alpha = youLose.alpha + 0.01 
end 

-- MoveYouLose will be called over and over again 
Runtime:addEventListener("enterFrame", MoveYouLose)

-----------------------------------------------------------------------------------------
-- OBJECT CREATION
-----------------------------------------------------------------------------------------

-- displays a question and sets the colour 
questionObject = display.newText( "", 405, 370, nil, 60, Arial, textSize)
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

-- display the correct answer if eneterd incorrectly 
actualAnswerText = display.newText("", 480, 505, nil, 35)
actualAnswerText:setTextColor(225/255, 110/255, 110/255)
actualAnswerText.isVisible = false

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

-- create the you win image 
youWin = display.newImageRect("Images/youWin.jpg", 1024, 768)
youWin.x = 512
youWin.y = 384
youWin.isVisible = false

-- create the you lose image 
youLose = display.newImageRect("Images/youLose.jpg", 824, 568)
youLose.x = -800
youLose.y = 384
youLose.isVisible = false
youLose.alpha = 0.7

-----------------------------------------------------------------------------------------
-- FUNCTION CALLS 
-----------------------------------------------------------------------------------------

-- call the function to ask a question 
AskQuestion()

-- call the function to start the timer 
StartTimer()

























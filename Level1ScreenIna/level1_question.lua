-----------------------------------------------------------------------------------------
--
-- level1_screen.lua
-- Created by: Allison
-- Date: May 16, 2017
-- Description: This is the level 1 screen of the game. the charater can be dragged to move
--If character goes off a certain araea they go back to the start. When a user interactes
--with piant a trivia question will come up. they will have a limided time to click on the answer
-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
-- INITIALIZATIONS
-----------------------------------------------------------------------------------------

-- Use Composer Libraries
local composer = require( "composer" )
local widget = require( "widget" )
local physics = require( "physics")


-----------------------------------------------------------------------------------------

-- Naming Scene
sceneName = "level1_question"

-----------------------------------------------------------------------------------------

-- Creating Scene Object
local scene = composer.newScene( sceneName )

-----------------------------------------------------------------------------------------
-- SOUNDS
-----------------------------------------------------------------------------------------
local correctSound = audio.loadSound("Sounds/correctSound.mp3")
local correctSoundChannel
local wrongSound = audio.loadSound("Sounds/wrongSound.mp3")
local wrongSoundChannel

-----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------

-- The local variables for this scene
local questionText

local randomQuestionNumber 

local answerText 
local wrongAnswerText1
local wrongAnswerText2
local wrongAnswerText3
local actualAnswer
local answerPosition = 1
local bkg
local cover

local X1 = 256
local X2 = 600
local Y1 = display.contentHeight*1/2
local Y2 = display.contentHeight*5.5/7

local userAnswer
local textTouched = false

-----------------------------------------------------------------------------------------
--LOCAL FUNCTIONS
-----------------------------------------------------------------------------------------

--making transition to next scene when answer is correct 
local function BackToLevel1() 
    composer.hideOverlay("crossFade", 400 )
  
    ResumeGame()
end 

--making transition to next scene when answer is wrong
local function BackToLevel1Wrong() 
    composer.hideOverlay("crossFade", 5000 )
    actualAnswer.isVisible = true 
    actualAnswer.text = "The correct answer is ".. answerText.text
  
    ResumeGame()
end 

-----------------------------------------------------------------------------------------
--checking to see if the user pressed the right answer and bring them back to level 1
local function TouchListenerAnswer(touch)
    userAnswer = answerText.text
    
    if (touch.phase == "ended") then

        if (soundOn == true) then 
            -- play sound effect 
            correctSoundChannel = audio.play( correctSound, {channel = 6, loops = 1})
        end

        BackToLevel1( )
    
    end 
end

--checking to see if the user pressed the right answer and bring them back to level 1
local function TouchListenerWrongAnswer(touch)
    userAnswer = wrongText1.text
    
    if (touch.phase == "ended") then
         
        if (soundOn == true) then 
            -- play sound effect 
            wrongSoundChannel = audio.play( wrongSound, {channel = 5, loops = 1})
        end
        
        BackToLevel1Wrong( )
        
    end 
end

--checking to see if the user pressed the right answer and bring them back to level 1
local function TouchListenerWrongAnswer2(touch)
    userAnswer = wrongText2.text
    
    if (touch.phase == "ended") then
         
        if (soundOn == true) then 
            -- play sound effect 
            wrongSoundChannel = audio.play( wrongSound, {channel = 5, loops = 1})
        end

        BackToLevel1Wrong( )
        
    end 
end

--checking to see if the user pressed the right answer and bring them back to level 1
local function TouchListenerWrongAnswer3(touch)
    userAnswer = wrongText3.text
    
    if (touch.phase == "ended") then

        if (soundOn == true) then 
            -- play sound effect 
            wrongSoundChannel = audio.play( wrongSound, {channel = 5, loops = 1})
        end

        BackToLevel1Wrong( )
        
    end 
end


--adding the event listeners 
local function AddTextListeners ( )
    answerText:addEventListener( "touch", TouchListenerAnswer )
    wrongText1:addEventListener( "touch", TouchListenerWrongAnswer)
    wrongText2:addEventListener( "touch", TouchListenerWrongAnswer2)
    wrongText3:addEventListener( "touch", TouchListenerWrongAnswer3)
end

--removing the event listeners
local function RemoveTextListeners()
    answerText:removeEventListener( "touch", TouchListenerAnswer )
    wrongText1:removeEventListener( "touch", TouchListenerWrongAnswer)
    wrongText2:removeEventListener( "touch", TouchListenerWrongAnswer2)
    wrongText3:removeEventListener( "touch", TouchListenerWrongAnswer3)
end


local function DisplayQuestion()

    -- choose a random question number between 1 and 10
    randomQuestionNumber = math.random(1,10)

    if (randomQuestionNumber == 1) then 
        --creating the question depending on the selcetion number
        questionText.text = "What two colours make green?"

        --creating answer text from list it corispondes with the animals list
        answerText.text = "yellow + blue"

        --creating wrong answers
        wrongText1.text = "red + orange"
        wrongText2.text = "black + blue" 
        wrongText3.text = "yellow + red"

    elseif (randomQuestionNumber == 2) then
        --creating the question depending on the selcetion number
        questionText.text = "What two colours make purple?" 

        --creating answer text from list it corispondes with the animals list
        answerText.text = "red + blue"

        --creating wrong answers
        wrongText1.text = "orange + blue"
        wrongText2.text = "red + black" 
        wrongText3.text = "green + yellow"

    elseif (randomQuestionNumber == 3) then
        --creating the question depending on the selcetion number
        questionText.text = "What two colours make orange?" 

        --creating answer text from list it corispondes with the animals list
        answerText.text = "red + yellow"

        --creating wrong answers
        wrongText1.text = "brown + blue"
        wrongText2.text = "red + green" 
        wrongText3.text = "purple + yellow"

    elseif (randomQuestionNumber == 4) then
        --creating the question depending on the selcetion number
        questionText.text =  "How many colours are in the rainbow?"

        --creating answer text from list it corispondes with the animals list
        answerText.text = "7"

        --creating wrong answers
        wrongText1.text = "8"
        wrongText2.text = "4"
        wrongText3.text = "6"

    elseif (randomQuestionNumber == 5) then
        --creating the question depending on the selcetion number
        questionText.text = "Which is the primary colour?"

        --creating answer text from list it corispondes with the animals list
        answerText.text = "red"

        --creating wrong answers
        wrongText1.text = "orange"
        wrongText2.text = "black"
        wrongText3.text = "green"

    elseif (randomQuestionNumber == 6) then
        --creating the question depending on the selcetion number
        questionText.text =  "How many prmiary colours are there?"

        --creating answer text from list it corispondes with the animals list
        answerText.text = "3"

        --creating wrong answers
        wrongText1.text = "2"
        wrongText2.text = "5"
        wrongText3.text = "4"

    elseif (randomQuestionNumber == 7) then
        --creating the question depending on the selcetion number
        questionText.text = "Which is the primary colour?"

        --creating answer text from list it corispondes with the animals list
        answerText.text = "blue"

        --creating wrong answers
        wrongText1.text = "purple"
        wrongText2.text = "white"
        wrongText3.text = "gold" 

    elseif (randomQuestionNumber == 8) then
        --creating the question depending on the selcetion number
        questionText.text = "Which is the primary colour?"

        --creating answer text from list it corispondes with the animals list
        answerText.text = "yellow"

        --creating wrong answers
        wrongText1.text = "brown"
        wrongText2.text = "grey"
        wrongText3.text = "violet"

    elseif (randomQuestionNumber == 9) then
        --creating the question depending on the selcetion number
        questionText.text =  "Which is the secondary colour?"

        --creating answer text from list it corispondes with the animals list
        answerText.text = "purple"
        --creating wrong answers
        wrongText1.text = "blue"
        wrongText2.text = "red"
        wrongText3.text = "yellow"

    elseif (randomQuestionNumber == 10) then
        --creating the question depending on the selcetion number
        questionText.text = "Which is the secondary colour?"

        --creating answer text from list it corispondes with the animals list
        answerText.text = "orange"

        --creating wrong answers
        wrongText1.text = "black"
        wrongText2.text = "white"
        wrongText3.text = "brown"
    end
end
   
local function PositionAnswers()

    --creating random start position in a cretain area
    answerPosition = math.random(1,4)

    if (answerPosition == 1) then

        answerText.x = X1
        answerText.y = Y1
        
        wrongText1.x = X1
        wrongText1.y = Y2
        
        wrongText2.x = X2
        wrongText2.y = Y2

        wrongText3.x = X2
        wrongText3.y = Y1

        
    elseif (answerPosition == 2) then

        answerText.x = X2
        answerText.y = Y1
            
        wrongText1.x = X2
        wrongText1.y = Y2
            
        wrongText2.x = X1
        wrongText2.y = Y2

        wrongText3.x = X1
        wrongText3.y = Y1

         

    elseif (answerPosition == 3) then

        answerText.x = X2
        answerText.y = Y1
            
        wrongText1.x = X1
        wrongText1.y = Y2
            
        wrongText2.x = X1
        wrongText2.y = Y1

        wrongText3.x = X2
        wrongText3.y = Y2

     elseif (answerPosition == 4) then

        answerText.x = X1
        answerText.y = Y1
            
        wrongText1.x = X1
        wrongText1.y = Y2
            
        wrongText2.x = X2
        wrongText2.y = Y1

        wrongText3.x = X2
        wrongText3.y = Y2
            
    end
end

-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view  

    -----------------------------------------------------------------------------------------
    --covering the other scene with a rectangle so it looks faded and stops touch from going through
    bkg = display.newRect(display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight)
    --setting to a semi black colour
    bkg:setFillColor(0,0,0,0.5)

    -----------------------------------------------------------------------------------------
    --making a cover rectangle to have the background fully bolcked where the question is
    cover = display.newRoundedRect(display.contentCenterX, display.contentCenterY, display.contentWidth*0.8, display.contentHeight*0.95, 50 )
    --setting its colour
    cover:setFillColor(96/255, 96/255, 96/255)

    -- create the question text object
    questionText = display.newText("", display.contentCenterX, display.contentCenterY*3/8, Arial, 45)

    -- create the answer text object & wrong answer text objects
    answerText = display.newText("", X1, Y2, Arial, 40)
    answerText.anchorX = 0
    wrongText1 = display.newText("", X2, Y2, Arial, 40)
    wrongText1.anchorX = 0
    wrongText2 = display.newText("", X1, Y1, Arial, 40)
    wrongText2.anchorX = 0
    wrongText3 = display.newText("", X2, Y1, Arial, 40)
    wrongText3.anchorX = 0
    actualAnswer = display.newText("", 512, 700, Arial, 40)
    actualAnswer.isVisible = false
    -----------------------------------------------------------------------------------------

    -- insert all objects for this scene into the scene group
    sceneGroup:insert(bkg)
    sceneGroup:insert(cover)
    sceneGroup:insert(questionText)
    sceneGroup:insert(answerText)
    sceneGroup:insert(wrongText1)
    sceneGroup:insert(wrongText2)
    sceneGroup:insert(wrongText3)
    sceneGroup:insert(actualAnswer)

end --function scene:create( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to appear on screen
function scene:show( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view
    local phase = event.phase

    -----------------------------------------------------------------------------------------

    if ( phase == "will" ) then

        -- Called when the scene is still off screen (but is about to come on screen).
    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then
        -- Called when the scene is now on screen.
        -- Insert code here to make the scene come alive.
        -- Example: start timers, begin animation, play audio, etc.
        DisplayQuestion()
        PositionAnswers()
        AddTextListeners()
    end

end --function scene:show( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to leave the screen
function scene:hide( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view
    local phase = event.phase

    -----------------------------------------------------------------------------------------

    if ( phase == "will" ) then
        -- Called when the scene is on screen (but is about to go off screen).
        -- Insert code here to "pause" the scene.
        -- Example: stop timers, stop animation, stop audio, etc.
        --parent:resumeGame()
    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then
        -- Called immediately after scene goes off screen.
        RemoveTextListeners()
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

end -- function scene:destroy( event )

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
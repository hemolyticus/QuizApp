//
//  ViewController.swift
//  TrueFalseStarter
//
//  Created by Pasan Premaratne on 3/9/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import UIKit
import GameKit
import AudioToolbox

class ViewController: UIViewController {
    //Variables
    let questionsPerRound = 5
    var questionsAsked = 0
    var correctQuestions = 0
    var indexOfSelectedQuestion: Int = 0
    var correctAnswer: String = ""
    var wrongSound: SystemSoundID = 0
    var correctSound: SystemSoundID = 0
    var gameSound: SystemSoundID = 0
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var option1Button: UIButton!
    @IBOutlet weak var option2Button: UIButton!
    @IBOutlet weak var option3Button: UIButton!
    @IBOutlet weak var option4Button: UIButton!
    @IBOutlet weak var playAgainButton: UIButton!
    
// This function is called after the View Controller has loaded its view into the memory
    override func viewDidLoad() {
        super.viewDidLoad()
        loadAllSounds()
        playGameStartSound()
        displayQuestion()
        
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 // This playAgainfunction is called once the player decides to play the game again. It resets the values of the variables: questionsAsked, correctQuestions, and indexOfSelectedQuestions. It also call the regenerateQuestionArray(), displayQuestion(), and showOptionButtonHidePlayAgainButton()
    @IBAction func playAgain(_ sender: Any) {
        
        questionsAsked = 0
        correctQuestions = 0
        indexOfSelectedQuestion = 0
        regenerateQuestionArray()
        displayQuestion()
        showOptionButtonHidePlayAgainButton()
    }
    
// The display Question()  calls the generateRandomQuestion() which returns a question and assigns it to variable called questionToDisplay. It also assigns the correct answer to a global variable that is used to check answers. Each to the property of the questionToDisplay is assigned to the appropriate UI object. This also increments the numbers of questions asked and hides the playAgainButton
    func displayQuestion() {
        questionsAsked += 1
        let questionToDisplay = generateRandomQuestion()
        correctAnswer =
            questionToDisplay.correctAnswer
        questionLabel.text = questionToDisplay.question
        enableOptionButtons()
        option1Button.setTitle(questionToDisplay.option1, for: .normal)
        option2Button.setTitle(questionToDisplay.option2, for: .normal)
        option3Button.setTitle(questionToDisplay.option3, for: .normal)
        option4Button.setTitle(questionToDisplay.option4, for: .normal)
        playAgainButton.isHidden = true
       
    }
    
    
//This function displays the score of the players once the game is finished
    func displayScore() {
        
        hideOptionButtonShowPlayAgainButton()
        questionLabel.text = "You got \(correctQuestions) correct answers out of \(questionsPerRound) questions!"
        
    }

//This function checks the answer selected by the user among the options using the correctAnswer variables and adds 1 to the correctQuestions variable if the answer is correct and replaces  the questionTextField temporarily with correct or wrong! It also calls the loadNextRound() after 2 seconds
    @IBAction func checkAnswer(_ sender: UIButton) {
        
        if (sender.titleLabel!.text == correctAnswer) {
            correctQuestions += 1
            questionLabel.text = "Correct!"
            playCorrectSound()
            disableOptionButtons()
        }
        else
        {
            questionLabel.text = "Wrong"
            playWrongSound()
            disableOptionButtons()
        }
        
        loadNextRoundWithDelay(seconds: 2)
        
    }
//This function disables the option buttons which is called within  the checkAnswer()
    func disableOptionButtons()
    {
        option1Button.isEnabled = false
        option2Button.isEnabled = false
        option3Button.isEnabled = false
        option4Button.isEnabled = false

    }

//This function enables the option buttons. It is called within the displayQuestion()
    func enableOptionButtons()
    {
        option1Button.isEnabled = true
        option2Button.isEnabled = true
        option3Button.isEnabled = true
        option4Button.isEnabled = true
        
    }

//This function hides the option buttons and displays the playAgain button. This function is called once the game is finished and the score is displayed
    func hideOptionButtonShowPlayAgainButton()
    {
        option1Button.isHidden = true
        option2Button.isHidden = true
        option3Button.isHidden = true
        option4Button.isHidden = true
        playAgainButton.isHidden = false
    }

//This function shows the option buttons and hides the playAgain button while the game is ongoing
    func showOptionButtonHidePlayAgainButton()
    {
        option1Button.isHidden = false
        option2Button.isHidden = false
        option3Button.isHidden = false
        option4Button.isHidden = false
        playAgainButton.isHidden = true
    }
  
//This function determines whether the player has answer the maximum number of questions per round otherwise it would continue displaying question
    func nextRound() {
        if questionsAsked == questionsPerRound {
            // Game is over
            displayScore()
        } else {
            // Continue game
            displayQuestion()
        }
    }
    
    func loadNextRoundWithDelay(seconds: Int) {
        // Converts a delay in seconds to nanoseconds as signed 64 bit integer
        let delay = Int64(NSEC_PER_SEC * UInt64(seconds))
        // Calculates a time value to execute the method given current time and delay
        let dispatchTime = DispatchTime.now() + Double(delay) / Double(NSEC_PER_SEC)
        
        // Executes the nextRound method at the dispatch time on the main queue
        DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
            self.nextRound()
        }
    }
 
/*******
 Sound Functions
 ******/

//This function locates the game sound in the resource shipped with the app and initialises the URL with the given data which then allows for the creation of a system sound object, gameStartSound
    func loadGameStartSound() {
        let pathToSoundFile = Bundle.main.path(forResource: "GameSound", ofType: "wav")
        let soundURL = URL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL as CFURL, &gameSound)
    }

//This function locates the correct sound in the resource shipped with the app and initialises the URL with the given data which then allows for the creation of a system sound object, correctSound
    func loadCorrectSound()
    {
        let pathToSoundFile = Bundle.main.path(forResource: "correct", ofType: "wav")
        let soundURL = URL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL as CFURL, &correctSound)
    }

//This function locates the wrong sound in the resource shipped with the app and initialises the URL with the given data which then allows for the creation of a system sound object, wrongSound
    func loadWrongSound()
    {
        let pathToSoundFile = Bundle.main.path(forResource: "wrong", ofType: "wav")
        let soundURL = URL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL as CFURL, &wrongSound)
    }
        
    func loadAllSounds()
    {
        loadGameStartSound()
        loadCorrectSound()
        loadWrongSound()
        }

//This function plays before the game starts. This function might be deleted in future iterations of the project
    func playGameStartSound() {
        AudioServicesPlaySystemSound(gameSound)
    }

//This function plays the wrong sound if the user got the wrong answer
    func playWrongSound() {
    AudioServicesPlaySystemSound(wrongSound)
    
    }
    
//This function plays the corect sound if the user got the correct answer
    func playCorrectSound() {
        AudioServicesPlaySystemSound(correctSound)
        
    }
        
    
    
}


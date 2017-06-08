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
    
    let questionsPerRound = 5
    var questionsAsked = 0
    var correctQuestions = 0
    var indexOfSelectedQuestion: Int = 0
    
    var wrongSound: SystemSoundID = 0
    var correctSound: SystemSoundID = 0

    var gameSound: SystemSoundID = 0
    
    var questionToDisplay = generateRandomQuestion()
    
    
    @IBOutlet weak var questionLabel: UILabel!
   
    @IBOutlet weak var option1Button: UIButton!
    
    @IBOutlet weak var option2Button: UIButton!

    @IBOutlet weak var option3Button: UIButton!
   
    
    @IBOutlet weak var option4Button: UIButton!
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
    
    func displayQuestion() {
        indexOfSelectedQuestion = GKRandomSource.sharedRandom().nextInt(upperBound: questionArray.count)
        let questionToDisplay = questionArray[indexOfSelectedQuestion]
        questionLabel.text = questionToDisplay.question
        enableOptionButtons()
        option1Button.setTitle(questionToDisplay.option1, for: .normal)
        option2Button.setTitle(questionToDisplay.option2, for: .normal)
        option3Button.setTitle(questionToDisplay.option3, for: .normal)
        option4Button.setTitle(questionToDisplay.option4, for: .normal)
       
    }
    
    
    
    func displayScore() {
        
        
    }
    
    
    @IBAction func checkAnswer(_ sender: UIButton) {
       
        let correctAnswer =
         questionToDisplay.correctAnswer.to
        
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
    
    func disableOptionButtons()
    {
        option1Button.isEnabled = false
        option2Button.isEnabled = false
        option3Button.isEnabled = false
        option4Button.isEnabled = false

    }
    
    func enableOptionButtons()
    {
        option1Button.isEnabled = true
        option2Button.isEnabled = true
        option3Button.isEnabled = true
        option4Button.isEnabled = true
        
    }
    
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



    
       // loadNextRoundWithDelay(seconds: 2)

    
    
    
    //func nextRound() {
      //  if questionsAsked == questionsPerRound {
            // Game is over
        //    displayScore()
        //} else {
            // Continue game
          //  displayQuestion()
        //}
    //}
    
   // @IBAction func playAgain() {
     //      }
    

    
    // MARK: Helper Methods
    
//    func loadNextRoundWithDelay(seconds: Int) {
//        // Converts a delay in seconds to nanoseconds as signed 64 bit integer
//        let delay = Int64(NSEC_PER_SEC * UInt64(seconds))
//        // Calculates a time value to execute the method given current time and delay
//        let dispatchTime = DispatchTime.now() + Double(delay) / Double(NSEC_PER_SEC)
//        
//        // Executes the nextRound method at the dispatch time on the main queue
//        DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
//            self.nextRound()
//        }
//    }

/*******
 Score Calculation Functions
 *******/
    
        


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


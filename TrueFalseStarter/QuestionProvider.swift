//
//  QuestionProvider.swift
//  QuizApp
//
//  Created by Mel John del Barrio on 31/05/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import Foundation
import GameKit

struct Questions {
    var question: String?
    var option1: String?
    var option2: String?
    var option3: String?
    var option4: String?
    var correctAnswer: String
}

let question1 = Questions(question: "This was the only US President to serve more than two consecutive terms", option1: "George Washington", option2: "Franklin D. Roosevelt", option3: "Woodrow Wilson", option4: "Andrew Jackson", correctAnswer: "Franklin D. Roosevelt")

let question2 = Questions(question: "Which of the following countries has the most residents?", option1: "Nigeria", option2: "Russia", option3: "Iran", option4: "Vietnam", correctAnswer: "Nigeria")

let question3 = Questions(question: "1918", option1: "1919", option2: "1919", option3: "1945", option4: "1954", correctAnswer: "1945")

let question4 = Questions(question: "The Titanic departed from the United Kingdom, where was it supposed to arrive?", option1: "Paris", option2: "Washington D.C.", option3: "New York City", option4: "Boston", correctAnswer: "New York City")

let question5 = Questions(question: "Which nation produces the most oil?", option1: "Iran", option2: "Iraq", option3: "Brazil", option4: "Canada", correctAnswer: "Canada")

let question6 = Questions(question: "Which country has most recently won consecutive World Cups in Soccer?", option1: "Italy", option2: "Brazil", option3: "Argentina", option4: "Spain", correctAnswer: "Brazil")

let questionArray: [Questions] = [question1,question2, question3, question4, question5, question6]

func generateRandomQuestion() -> Questions
{
    let indexOfQuestion = GKRandomSource.sharedRandom().nextInt(upperBound: questionArray.count)
    
    return questionArray[indexOfQuestion]
}

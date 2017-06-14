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

var question1 = Questions(question: "This was the only US President to serve more than two consecutive terms", option1: "George Washington", option2: "Franklin D. Roosevelt", option3: "Woodrow Wilson", option4: "Andrew Jackson", correctAnswer: "Franklin D. Roosevelt")

var question2 = Questions(question: "Which of the following countries has the most residents?", option1: "Nigeria", option2: "Russia", option3: "Iran", option4: "Vietnam", correctAnswer: "Nigeria")

var question3 = Questions(question: "In what year was the United Nations founded?", option1: "1919", option2: "1919", option3: "1945", option4: "1954", correctAnswer: "1945")

var question4 = Questions(question: "The Titanic departed from the United Kingdom, where was it supposed to arrive?", option1: "Paris", option2: "Washington D.C.", option3: "New York City", option4: "Boston", correctAnswer: "New York City")

var question5 = Questions(question: "Which nation produces the most oil?", option1: "Iran", option2: "Iraq", option3: "Brazil", option4: "Canada", correctAnswer: "Canada")

var question6 = Questions(question: "Which country has most recently won consecutive World Cups in Soccer?", option1: "Italy", option2: "Brazil", option3: "Argentina", option4: "Spain", correctAnswer: "Brazil")


var question7 = Questions(question: "Which of the following rivers is longest?", option1: "Yangtze", option2: "Mississippi", option3: "Congo", option4: "Mekong", correctAnswer: "Mississippi")
var question8 = Questions(question: "Which city is the oldest?", option1: "Mexico City", option2: "Cape Town", option3: "Sydney", option4: "Spain", correctAnswer: "Mexico City")

var question9 = Questions(question: "Which country was the first to allow women to vote in national elections?", option1: "Poland", option2: "United States", option3: "Sweden", option4: "Senegal", correctAnswer: "Poland")

var question10 = Questions(question: "Which of these countries won the most medals in the 2012 Summer Games?", option1: "France", option2: "United States", option3: "Japan", option4: "Great Britain", correctAnswer: "Great Britain")


var questionArray: [Questions] = [question1,question2, question3, question4, question5, question6, question7, question8, question9, question10]

func generateRandomQuestion() -> Questions
{
    let indexQuestion = GKRandomSource.sharedRandom().nextInt(upperBound: questionArray.count)
    let questionToDisplay = questionArray[indexQuestion]
    removeQuestion(at: indexQuestion)
    return questionToDisplay
}
func removeQuestion(at index: Int)
{
    questionArray.remove(at: index)
}

func regenerateQuestionArray()
{
    questionArray = [question1,question2, question3, question4, question5, question6, question7, question8, question9, question10]
}

    

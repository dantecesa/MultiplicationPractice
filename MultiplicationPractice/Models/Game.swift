//
//  Game.swift
//  MultiplicationPractice
//
//  Created by Dante Cesa on 1/17/22.
//

import Foundation

class Game: ObservableObject {
    var multiplicationTable: Int = 2
    var numberOfQuestions: Int = 5
    
    var possibleAnswers: [Int] = []
    var correctAnswerIndex: Int = 0
    var currentMultiplier: Int = 0
    var numCorrect: Int = 0
    var currentQuestion: Int = 0
    
    var selectedNumberOfQuestions: Int = 0
    
    init(numberOfQuestions: Int, multiplicationTable: Int) {
        self.numberOfQuestions = numberOfQuestions
        self.multiplicationTable = multiplicationTable
        self.currentMultiplier = Int.random(in: 0...12)
        print("I'm alive!")
        loadNextQuestion()
    }
    
    deinit {
        print("I'm dead")
    }
    
    func loadNextQuestion() {
        for _ in 0...2 {
            possibleAnswers.insert(Int.random(in: 0...100), at: 0)
        }
        currentMultiplier = Int.random(in: 0...12)
        correctAnswerIndex = Int.random(in: 0...2)
        possibleAnswers[correctAnswerIndex] = multiplicationTable * currentMultiplier
    }
    
    func checkAnswer(forIndex index: Int) -> Bool {
        if index == correctAnswerIndex {
            numCorrect += 1
            currentQuestion += 1
            return true
        } else {
            currentQuestion += 1
            return false
        }
    }
    
    func checkAnswer(forInput input: String) -> Bool {
        if Int(input) == possibleAnswers[correctAnswerIndex] {
            numCorrect += 1
            currentQuestion += 1
            return true
        } else {
            currentQuestion += 1
            return false
        }
    }
    
    func reset() {
        numCorrect = 0
        currentQuestion = 0
        
        loadNextQuestion()
    }
}

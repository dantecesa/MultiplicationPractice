//
//  GuessGameView.swift
//  MultiplicationPractice
//
//  Created by Dante Cesa on 1/17/22.
//

import SwiftUI

struct GuessGameView: View {
    var currentGame: Game
    
    let numberOfQuestions: Int
    let multiplicationTable: Int
    
    init(numberOfQuestions: Int, multiplicationTable: Int) {
        self.numberOfQuestions = numberOfQuestions
        self.multiplicationTable = multiplicationTable
        currentGame = Game(numberOfQuestions: numberOfQuestions, multiplicationTable: multiplicationTable)
    }
    
    @State var alertText: String = ""
    @State var alertMessage: String = ""
    @State var showAlert: Bool = false
    
    @State var userInput: String = ""
    
    @State private var showScoreScreen: Bool = false
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.green, .blue], startPoint: .top, endPoint: .bottom).ignoresSafeArea()
            VStack (spacing: 20) {
                Spacer()
                Text("What is \(currentGame.multiplicationTable) x \(currentGame.currentMultiplier)?")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                TextField("Answer…", text: $userInput)
                    .frame(width: 200, height: 100, alignment: .center)
                    .font(.largeTitle)
                    .background(.ultraThickMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                    .foregroundColor(.secondary)
                    .keyboardType(.numberPad)
                    .onSubmit {
                        makeGuess()
                    }
                Button("Submit") {
                    makeGuess()
                }
                Spacer()
                Spacer()
                Spacer()
                    .navigationTitle("\(currentGame.currentQuestion + 1)/\(currentGame.numberOfQuestions)")
                    .navigationBarTitleDisplayMode(.inline)
            }
            .alert(alertText, isPresented: $showAlert) {
                Button("OK") {
                    if currentGame.currentQuestion < currentGame.numberOfQuestions {
                        currentGame.loadNextQuestion()
                    } else {
                        showScoreScreen = true
                    }
                }
            } message: {
                Text(alertMessage)
            }
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Submit") {
                        makeGuess()
                    }
                }
            }
        }
        .fullScreenCover(isPresented: $showScoreScreen) {
            ZStack {
                Color
                    .black
                    .edgesIgnoringSafeArea(.all)
                VStack (spacing: 20) {
                    Spacer()
                    Text("🎉 Good Job!!")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                    Text("Your final score was: \(currentGame.numCorrect)/\(currentGame.numberOfQuestions)")
                        .font(.title2)
                        .foregroundColor(.white)
                    Button("Try again") {
                        currentGame.reset()
                        showScoreScreen = false
                        self.mode.wrappedValue.dismiss()
                    }
                    Spacer()
                }
            }
        }
    }
    
    func makeGuess() {
        if currentGame.checkAnswer(forInput: userInput) == true {
            alertText = "That's right!"
            alertMessage = ""
        } else {
            alertText = "Nope. The answer was: \(currentGame.possibleAnswers[currentGame.correctAnswerIndex])"
            alertMessage = "\(currentGame.multiplicationTable) x \(currentGame.currentMultiplier) = \(currentGame.possibleAnswers[currentGame.correctAnswerIndex])"
        }
        showAlert = true
        userInput = ""
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GuessGameView(numberOfQuestions: 5, multiplicationTable: 2)
    }
}

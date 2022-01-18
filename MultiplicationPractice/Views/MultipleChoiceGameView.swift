//
//  MultipleChoiceGame.swift
//  MultiplicationPractice
//
//  Created by Dante Cesa on 1/17/22.
//

import SwiftUI

struct MultipleChoiceGameView: View {
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
                Spacer()
                ForEach(0...2, id:\.self) { index in
                    Button(action: {
                        if currentGame.checkAnswer(forIndex: index) == true {
                            alertText = "That's right!"
                            alertMessage = ""
                        } else {
                            alertText = "Nope. The answer was: \(currentGame.possibleAnswers[currentGame.correctAnswerIndex])"
                            alertMessage = "\(currentGame.multiplicationTable) x \(currentGame.currentMultiplier) = \(currentGame.possibleAnswers[currentGame.correctAnswerIndex])"
                        }
                        showAlert = true
                    }, label: {
                        Text("\(currentGame.possibleAnswers[index])").font(.title2)
                    }).padding(30)
                        .frame(width: 200, height: 60)
                        .background(.thinMaterial)
                        .foregroundColor(.secondary)
                        .clipShape(Capsule())
                }
                Spacer()
                Spacer()
                    .navigationTitle("\(currentGame.currentQuestion + 1)/\(currentGame.numberOfQuestions)")
                    .navigationBarTitleDisplayMode(.inline)
            }.alert(alertText, isPresented: $showAlert) {
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
        }
        .fullScreenCover(isPresented: $showScoreScreen) {
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                VStack (spacing: 20) {
                    Spacer()
                    Text("🎉 Good Job!!")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                    Text("Your final score was: \(currentGame.numCorrect)/\(currentGame.numberOfQuestions)")
                        .font(.title2)
                        .foregroundColor(.white)
                    Button("Try again") {
                        self.mode.wrappedValue.dismiss()
                        showScoreScreen = false
                        currentGame.reset()
                    }
                    Spacer()
                }
            }
        }
    }
}

struct MultipleChoiceGame_Previews: PreviewProvider {
    static var previews: some View {
        MultipleChoiceGameView(numberOfQuestions: 5, multiplicationTable: 2)
    }
}

extension UINavigationController {
  func popToViewController(ofClass: AnyClass, animated: Bool = true) {
    if let vc = viewControllers.last(where: { $0.isKind(of: ofClass) }) {
      popToViewController(vc, animated: animated)
    }
  }
}

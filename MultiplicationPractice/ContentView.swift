//
//  ContentView.swift
//  MultiplicationPractice
//
//  Created by Dante Cesa on 1/17/22.
//

import SwiftUI

struct ContentView: View {
    @State private var multiplicationTable: Int = 2
    
    private let numQuestions: [Int] = [5, 10, 20]
    @State private var selectedNumQuestions = 5
    
    private let difficulty: [String] = ["Multiple Choice", "Fill in the blank"]
    @State private var selectedDifficulty: Int = 0
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    Stepper("Pick Number: \(multiplicationTable)", value: $multiplicationTable, in: 2...12)
                    Picker("Number of questions", selection: $selectedNumQuestions) {
                        ForEach(numQuestions, id:\.self) { number in
                            Text("\(number)")
                        }
                    }.pickerStyle(.automatic)
                    Picker("Difficulty", selection: $selectedDifficulty) {
                        ForEach(0..<difficulty.count) { index in
                            Text(difficulty[index])
                        }
                    }.pickerStyle(.segmented)
                } header: {
                    Text("Configure your practice")
                }
                
                Section {
                    NavigationLink("New Game") {
                        if selectedDifficulty == 0 {
                            MultipleChoiceGameView(numberOfQuestions: selectedNumQuestions, multiplicationTable: multiplicationTable)
                        } else {
                            GuessGameView(numberOfQuestions: selectedNumQuestions, multiplicationTable: multiplicationTable)
                        }
                    }
                } header: {
                    Text("Let's go!")
                }
            }.navigationTitle("Multiplication Practice").navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

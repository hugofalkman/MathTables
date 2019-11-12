//
//  AskQuestions.swift
//  MathTables
//
//  Created by H Hugo Falkman on 11/11/2019.
//  Copyright © 2019 H Hugo Falkman. All rights reserved.
//

import SwiftUI

struct AskQuestions: View {
    @ObservedObject var data: QuestionData
    @State private var currentQuestions = [Question(question: "1 x 1", answer: 1)]
    @State private var currentQuestion = 0
    @State private var answer = ""
    @State private var score = 0
    @State private var showResults = false
    
    var numAnswer: Int {
        Int(answer) ?? 1
    }
    
    var body: some View {
        Group {
            if !showResults {
                Text("What is \(currentQuestions[currentQuestion].question)")
                    .padding(.bottom)
                
                TextField("Your answer", text: $answer) {
                    if self.numAnswer == self.currentQuestions[self.currentQuestion].answer {
                        self.score += 1
                    }
                    if self.currentQuestion < self.data.numberOfQuestions - 1 {
                        self.currentQuestion += 1
                    } else {
                        self.showResults.toggle()
                    }
                }
                .padding(.horizontal)
                .frame(width: 180)
                .background(Color.white)
                .foregroundColor(.black)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .keyboardType(.numberPad)
                .padding(.bottom)
            
            } else {
                Text("You answered \(score) out of \(data.numberOfQuestions) questions correctly.")
                
                Button(action: {
                    self.score = 0
                    self.showResults.toggle()
                    self.data.gameActive.toggle()
                }) {
                    Text("New questions?")
                        .padding()
                        .clipShape(Capsule())
                        .overlay(Capsule().stroke(Color.white, lineWidth: 1))
                        .shadow(color: .white, radius: 2)
                        .padding(50)
                }
            }
            
            Spacer()
        }
        .font(.title)
        .onAppear(perform: shuffle)
    }
    
    func shuffle() {
        currentQuestions = Array(data.questions.prefix(data.tableSize[data.uptoTable - 1])).shuffled()
    }
}

struct AskQuestions_Previews: PreviewProvider {
    static var previews: some View {
        AskQuestions(data: QuestionData())
    }
}

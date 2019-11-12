//
//  AskSettings.swift
//  MathTables
//
//  Created by H Hugo Falkman on 11/11/2019.
//  Copyright © 2019 H Hugo Falkman. All rights reserved.
//

import SwiftUI

struct AskSettings: View {
    @ObservedObject var data: QuestionData
    @State private var questionStep = 0
    
    var maxTable: Int
    
    var questionSteps: [Int] {
        let all = data.tableSize[data.uptoTable - 1]
        var steps = [5, 10, 20].filter { $0 < all }
        steps.append(all)
        return steps
    }
    
    var body: some View {
        Group {
            VStack(alignment: .leading) {
                Section(header:
                    Text("Please adjust settings:")
                        .padding(.bottom)
                        .font(.headline)
                        .lineLimit(nil)
                ) {
                    
                    Stepper(value: $data.uptoTable, in: 1...maxTable) {
                        Text("Up to and including\nMath table \(data.uptoTable)")
                            .lineLimit(nil)
                    }
                    .padding(.leading)
                    .foregroundColor(.black)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    //.padding(.top, 50)
                    
                    Stepper(value: $questionStep, in: 0...(questionSteps.count - 1)) {
                        if questionStep == questionSteps.count - 1 {
                            Text("# of questions to answer: All")
                                .lineLimit(nil)
                        } else {
                            Text("# of questions to answer: \(questionSteps[questionStep])")
                                .lineLimit(nil)
                        }
                    }
                    .padding(.leading)
                    .foregroundColor(.black)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.top)
                }
            }
            
            Button(action: {
                self.data.numberOfQuestions = self.questionSteps[self.questionStep]
                self.data.gameActive.toggle()
            }) {
                Text("Start questions")
                    .padding()
                    .clipShape(Capsule())
                    .overlay(Capsule().stroke(Color.white, lineWidth: 1))
                    .shadow(color: .white, radius: 2)
                    .padding(50)
            }
        }
        .padding(.horizontal)
    }
}

struct AskSettings_Previews: PreviewProvider {
    static var previews: some View {
        AskSettings(data: QuestionData(), maxTable: 12)
    }
}

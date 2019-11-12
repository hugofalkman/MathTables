//
//  ContentView.swift
//  MathTables
//
//  Created by H Hugo Falkman on 03/11/2019.
//  Copyright © 2019 H Hugo Falkman. All rights reserved.
//

import SwiftUI

class QuestionData: ObservableObject {
    @Published var questions = [Question(question: "1 x 1", answer: 1)]
    @Published var tableSize = [1]
    
    @Published var uptoTable = 1
    @Published var numberOfQuestions = 1
    
    @Published var gameActive = false
}

struct ContentView: View {
    @ObservedObject var data = QuestionData()
    @State private var questionStep = 0
    let maxTable = 12
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
                .zIndex(0)
            
            VStack {
                Text("Math Tables")
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .padding(50)
                    
                Spacer()
                
                if data.gameActive {
                    AskQuestions(data: data)
                } else {
                    AskSettings(data: data, maxTable: maxTable)
                }

                Spacer()
            }
            .animation(.easeInOut(duration: 0.7))
            .foregroundColor(.white)
            .zIndex(1)
        }
        .onAppear(perform: startGame)
    }
    
    func startGame() {
        var quests = [Question]()
        var size = [Int]()
        for table in 1...maxTable {
            for multiplier in 1...table {
               quests.append(Question(question: "\(multiplier) x \(table)?", answer: multiplier * table))
            }
            size.append(table * (table + 1) / 2)
        }
        data.questions = quests
        data.tableSize = size
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  ContentView.swift
//  MathTables
//
//  Created by H Hugo Falkman on 03/11/2019.
//  Copyright © 2019 H Hugo Falkman. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var questions = [Question(question: "1 x 1", answer: 1)]
    @State private var tableSize = [1]
    @State private var uptoTable = 1
    
    let maxTable = 5
    
    var currentQuestions: [Question] {
        Array(questions.prefix(tableSize[uptoTable - 1]))
    }
    
    var body: some View {
        
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
                .zIndex(0)
            
            VStack {
                Text("Math Tables")
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .padding(50)
                    
                Spacer()

                Text("\(currentQuestions.last!.question)")
                    .foregroundColor(.white)

                Spacer()
            }
            .zIndex(1)
        }
        .onAppear(perform: startGame)
    }
    
    func startGame() {
        questions = [Question]()
        tableSize = [Int]()
        for table in 1...maxTable {
            for multiplier in 1...table {
               questions.append(Question(question: "\(multiplier) x \(table)?", answer: multiplier * table))
            }
            tableSize.append(table * (table + 1) / 2)
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

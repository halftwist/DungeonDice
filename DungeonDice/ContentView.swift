//
//  ContentView.swift
//  DungeonDice
//
//  Created by John Kearon on 4/17/25.
//

import SwiftUI

struct ContentView: View {
    enum Dice: Int, CaseIterable {  // CaseInterable to enable iterationg through the Dice enum
        case four = 4
        case six = 6
        case eight = 8
        case ten = 10
        case twelve = 12
        case twenty = 20
        case hundred = 100
        
        func roll() -> Int {
            return Int.random(in: 1...self.rawValue)
        }
    }
    
    @State private var resultMessage = ""


    var body: some View {
        VStack {
            Text("Dungeon Dice")
                .font(.largeTitle)
                .fontWeight(.black)
                .foregroundColor(.red)
            
            Spacer()
            
            Text(resultMessage)
                .font(.largeTitle)
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
                .frame(height: 159)
            
            Spacer()
            
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 102))]) {
                ForEach(Dice.allCases, id: \.self) { die in
                    Button("\(die.rawValue)-sided") {
                        resultMessage = "You rolled a \(die.roll()) on a \(die.rawValue) - sided die."
                    }
                }
            }
            .buttonStyle(.borderedProminent)
            .tint(.red)

            }
        .padding()
    }
}

#Preview {
    ContentView()
}

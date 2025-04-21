//
//  ContentView.swift
//  DungeonDice
//
//  Created by John Kearon on 4/17/25.
//

import SwiftUI

struct ContentView: View {
    // CaseInterable to enable iterationg through the Dice enum
    // Identifiable A class of types whose instances hold the value of an entity with stable identity
    
    enum Dice: Int, CaseIterable, Identifiable {
        case four = 4
        case six = 6
        case eight = 8
        case ten = 10
        case twelve = 12
        case twenty = 20
        case hundred = 100
        
        // Computed properties
        var id: Int {   // make the enum Identifiable
            rawValue
        }
        
        var description: String { "\(rawValue)-sided" }
        
        func roll() -> Int {
            return Int.random(in: 1...self.rawValue)
        }
    }
    
    @State private var resultMessage = ""
    @State private var animationTrigger = false  // changes to this variable trigger the animation
    @State private var isDoneAnimating = true
    
    
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
//                .scaleEffect(isDoneAnimating ? 1.0 : 0.6)  // animate to 1.0 font scale
//                .opacity(isDoneAnimating ? 1.0 : 0.2)  // aniamate to 1.0 opacity
//                .rotation3DEffect(isDoneAnimating ? .degrees(360) : .degrees(0), axis: 1.0  ).ro
//                .rotation3DEffect(isDoneAnimating ? .degrees(360) : .degrees(0), axis: (x: 1.0, y: 0.0, z: 0.0
                .rotation3DEffect(isDoneAnimating ? .degrees(360) : .degrees(0), axis: (x: 1.0, y: 0.0, z: 0.0))
                .frame(height: 150)
                .onChange(of: animationTrigger) {
                    isDoneAnimating = false
                    // in code completion enter interpodurbou to get just 2 parameters
                    withAnimation(.interpolatingSpring(duration: 0.6, bounce: 0.4)) {
                        isDoneAnimating = true
                    }
//                    withAnimation(.spring(Spring(response: 0.3, dampingRatio: 0.4))) {
//                        isDoneAnimating = true
//                    }
                    }

            Spacer()
            
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 102))]) {
                ForEach(Dice.allCases) { die in
                    Button(die.description) {
                        resultMessage = "You rolled a \(die.roll()) on a \(die.rawValue) - sided die."
                        animationTrigger.toggle() // a change of this variable triggers an animation
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

//
//  Menus.swift
//  AnagramsApp
//
//  Created by Riley Koo on 5/25/24.
//

import SwiftUI

struct MenuView: View {
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var timeRemaining: Int = Global.timeLimit
    
    @State private var isActive = true
    @State var startToggle = false
    
    @State var prevScore = 0
    var body: some View {
        if startToggle {
            Text("Time: \(timeRemaining) s")
                .onChange(of: startToggle) {
                    if startToggle == true {
                        isActive = true
                    } else {
                        isActive = false
                    }
                }
                .onReceive(timer) { time in
                    guard isActive else { return }
                    
                    if timeRemaining > 0 {
                        timeRemaining -= 1
                    }
                }
                .onChange(of: timeRemaining) {
                    if timeRemaining == 0 && startToggle {
                        self.startToggle.toggle()
                        
                        timeRemaining = Global.timeLimit
                    }
                }
            GameView(game: game())
        } else {
            Button {
                startToggle.toggle()
            } label: {
                Text("Start")
                    .font(.title2.bold())
            }
        }
    }
}

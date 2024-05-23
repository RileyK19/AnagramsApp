//
//  UI.swift
//  AnagramsApp
//
//  Created by Riley Koo on 5/22/24.
//

import SwiftUI

struct GameView: View {
    @State var game: game
    @State var curWord = " "
    @State var curScore = 0
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 10)
            Text("Anagrams")
                .font(.title.bold())
            Spacer()
                .frame(height: 25)
            Text("\(curScore)")
                .font(.title2.bold())
            Spacer()
            Text("\(curWord.uppercased())")
                .font(.title2.bold())
                .foregroundStyle((Global.isReal(word: curWord) && curWord.count > 2) ? .green : .primary)
            Spacer()
                .frame(height: 25)
            HStack {
                Spacer()
                ForEach(Array(0..<Global.gridSize), id:\.self) { x in
                    Button {
                        curWord = game.select(x)
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 15)
                                .frame(width: 47, height: 47)
                                .foregroundStyle(game.chars[x].selected ? .green : .blue)
                                .opacity(0.75)
                            Text(game.chars[x].char.uppercased())
                                .bold()
                                .foregroundStyle(.white)
                            
                        }
                    }
                }
                Spacer()
            }
            Spacer()
                .frame(height: 25)
            Button {
                curScore = game.submit()
                curWord = " "
            } label: {
                Text("Submit")
                    .bold()
            }
            Spacer()
            Spacer()
                .frame(height: 50)
        }
        .onChange(of: game.lettersSelected) { _, newValue in
            if newValue == "" {
                curWord = " "
            }
        }
    }
}

//
//  Logic.swift
//  AnagramsApp
//
//  Created by Riley Koo on 5/22/24.
//

import Foundation

struct box: Equatable {
    var char: String
    var id: Int
    var selected: Bool
}

class game: Equatable {
    var chars: [box]
    var lettersSelected: String
    var charsSelected: [box]
//    var selected: [Bool]
    var submitted: [String]
    var score: Int
    private var tmp = ""
    init() {
        chars = []
        lettersSelected = ""
//        selected = []
        submitted = []
        score = 0
        
        charsSelected = []
        
        for x in 0..<Global.gridSize {
            chars.append(box(char: getChar(), id: x, selected: false))
            
//            selected.append(false)
//            chars.append(getChar())
        }
    }
    private func getChar() -> String {
        var ret = ""
        if tmp == "" {
            for x in Global.lettersRarity {
                for _ in 0..<x.value {
                    tmp += x.key
                }
            }
        }
        ret += "\(tmp.randomElement()!)"
        return ret
    }
    func select(_ index: Int) -> String{
        calcAns()
        
        if index < Global.gridSize && !chars[index].selected {
            lettersSelected += chars[index].char
            chars[index].selected = true
            
            charsSelected.append(chars[index])
        } else if chars[index].selected {
            return deselect(index)
        }
        return lettersSelected
    }
    func deselect(_ index: Int) -> String {
        if index < Global.gridSize && chars[index].selected {
            if let x = charsSelected.lastIndex(where: { box in
                box.id == chars[index].id
            }) {
                charsSelected.remove(at: x)
                chars[index].selected = false
                
                calcAns()
            }
        }
        return lettersSelected
//        if index < Global.gridSize && chars[index].selected && lettersSelected.last! == chars[index].char.first {
//            lettersSelected.remove(at: lettersSelected.lastIndex(where: { _ in
//                return true
//            })!)
//            chars[index].selected = false
//        }
//        return lettersSelected
    }
    func submit() -> Int {
        calcAns()
        
        if Global.isReal(word: lettersSelected) && !submitted.contains(lettersSelected) && !submitted.contains(lettersSelected) {
            submitted.append(lettersSelected)
            score += Global.calcScore(lettersSelected.count)
        }
        
        charsSelected = []
        
        for x in 0..<Global.gridSize {
            chars[x].selected = false
        }
        lettersSelected = ""
        return score
    }
    static func == (lhs: game, rhs: game) -> Bool {
        return lhs.score == rhs.score &&
            lhs.lettersSelected == rhs.lettersSelected &&
            lhs.chars == rhs.chars
    }
    func calcAns() {
        var ret = ""
        for box in charsSelected {
            if box.selected {
                ret += box.char
            }
        }
        lettersSelected = ret
    }
}

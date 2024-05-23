//
//  Globals.swift
//  AnagramsApp
//
//  Created by Riley Koo on 5/22/24.
//

import Foundation
import UIKit

struct Global {
    
    static let gridSize = 7
    
    static let vowelSkew = 7
    
    static let lettersRarity: [String : Int] = [
        "a" : 43 + vowelSkew,
        "b" : 11,
        "c" : 23,
        "d" : 17,
        "e" : 57 + vowelSkew,
        "f" : 9,
        "g" : 13,
        "h" : 15,
        "i" : 38 + vowelSkew,
        "j" : 1,
        "k" : 6,
        "l" : 28,
        "m" : 15,
        "n" : 34,
        "o" : 37 + vowelSkew,
        "p" : 16,
        "q" : 1,
        "r" : 39,
        "s" : 29,
        "t" : 35,
        "u" : 19 + vowelSkew,
        "v" : 5,
        "w" : 7,
        "x" : 1,
        "y" : 9,
        "z" : 1
    ]
    
    static let timeLimit = 90
    
    static func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }
    
    
    static func calcScore(_ length: Int) -> Int {
        switch length {
        case 0: return 0
        case 1: return 0
        case 2: return 0
        case 3: return 100
        case 4: return 400
        case 5: return 800
        case 6: return 1400
        case 7: return 1800
        case 8: return 2200
        default: return (length - 8) * 400 + 2200
        }
    }
}

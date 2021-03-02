//
//  Game.swift
//  Apple Pie
//
//  Created by Нариман on 02.03.2021.
//

struct Game {
    var word: String
    var incorrectMovesRemainig: Int
    fileprivate var guessedLetters = [Character]()
    
    init(word: String, incorrectMovesRemainig: Int) {
        self.word = word
        self.incorrectMovesRemainig = incorrectMovesRemainig
    }
    
    var guessedWord: String {
        var wordToShow = ""
        for letter in word {
            if guessedLetters.contains(Character(letter.lowercased())) {
                wordToShow += String(letter)
            } else {
                wordToShow += "_"
            }
        }
        return wordToShow
    }
    
    mutating func playerGuessed(letter: Character) {
        let lowercasedLetter = Character(letter.lowercased())
        guessedLetters.append(lowercasedLetter)
        if !word.lowercased().contains(lowercasedLetter) {
            incorrectMovesRemainig -= 1
        }
    }
}

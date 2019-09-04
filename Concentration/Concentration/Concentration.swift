//
//  Concentration.swift
//  Concentration
//
//  Created by Frank Su on 2019-08-07.
//  Copyright © 2019 frankusu. All rights reserved.
//

import Foundation

struct Concentration {
    private (set) var cards = [Card]()
    private var indexOfOneAndOnlyFaceUpCard : Int? { //use closure to improve
        get { //filter => returns true then puts it in new array
            //simplified due to extension Collection
            //let faceUpCardIndices = cards.indices.filter {cards[$0].isFaceUp}
            //return faceUpCardIndices.count == 1 ? faceUpCardIndices.first : nil
            return cards.indices.filter{cards[$0].isFaceUp}.oneAndOnly
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    mutating func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at:\(index)):chosend index not in the cards")
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
            } else {
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards): you must have at least one pair of cards")
        for _ in 0..<numberOfPairsOfCards {
            let card = Card()
            cards += [card,card]
        }
        //cards.shuffle()
        
    }
}

extension Collection { //collection is generic type
    //strings, arrays, countableRanges all implement oneAndOnly
    var oneAndOnly : Element? { //generic is type element
        return count == 1 ? first : nil
    }
}

//
//  Card.swift
//  Concentration
//
//  Created by Frank Su on 2019-08-07.
//  Copyright © 2019 frankusu. All rights reserved.
//

import Foundation

struct Card : Hashable {
    

    static func == (lhs : Card, rhs : Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
//    var hashValue : Int {return identifier} depreicated
    func hash(into hasher : inout Hasher) {
        hasher.combine(identifier)
    }
    var isFaceUp = false
    var isMatched = false
    private var identifier : Int
    
    private static var identifierFactory = 0
    
    static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return Card.identifierFactory
    }
    init() {
        self.identifier = Card.getUniqueIdentifier()
        }
}

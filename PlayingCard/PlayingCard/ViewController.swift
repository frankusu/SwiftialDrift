//
//  ViewController.swift
//  PlayingCard
//
//  Created by Frank Su on 2019-09-12.
//  Copyright © 2019 frankusu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var deck = PlayingCardDeck()
    //Great place to put debugging code, checking things out. Initializing your view
    override func viewDidLoad() {
        super.viewDidLoad()
        for _ in 1...10 {
            if let card = deck.draw() {
                print("\(card)")
            }
        }
    }


}


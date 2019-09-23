//
//  ConcentrationThemeChooserViewController.swift
//  Concentration
//
//  Created by Frank Su on 2019-09-22.
//  Copyright © 2019 frankusu. All rights reserved.
//

import UIKit

class ConcentrationThemeChooserViewController: UIViewController {
    
    let themes = [ //bad design. What if Button name is not in english
        "Sports" : "⚽️🏀🏈⚾️🥎🎾🏐🏉🎱🏓⛷🎳⛳️",
        "Animals" : "🐶🐱🐭🐹🐰🦊🐻🐼🐨🐯🦁🐮🐷",
        "Faces" : "🙂😍😂😚😎🤩🥰😡🥶😱🙄😮😈👽",
    ]

 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Choose Theme" {
                if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
                    if let cvc = segue.destination as? ConcentrationViewController {
                        cvc.theme = theme
                    }
                }
            }
            
    }
}

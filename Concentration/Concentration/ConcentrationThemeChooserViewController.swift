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

    @IBAction func chooseTheme(_ sender: Any) {
        //change the theme but doesn't restart the game
        if let cvc = splitViewDetailConcentrationViewController {
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
                cvc.theme = theme
            }
        //keep in heap but gets thrown off navigation stack
        } else if let cvc = lastSeguedToConcentrationViewController {
                if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
                    cvc.theme = theme
                }
                //push onto navigation stack without segue
                navigationController?.pushViewController(cvc, animated: true)
        } else {
                //segue from code instead of StoryBoard
                performSegue(withIdentifier: "Choose Theme", sender: sender)
        }
    }

    
    private var splitViewDetailConcentrationViewController: ConcentrationViewController? {
        //return this splitviewControler's last viewcontroller (which is detail)
        return splitViewController?.viewControllers.last as? ConcentrationViewController
    }
    
    //normal var. Strong reference so going to keep cvc in heap.
    private var lastSeguedToConcentrationViewController : ConcentrationViewController?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Choose Theme" {
                if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
                    if let cvc = segue.destination as? ConcentrationViewController {
                        cvc.theme = theme
                        lastSeguedToConcentrationViewController = cvc
                    }
                }
        }
    }
}

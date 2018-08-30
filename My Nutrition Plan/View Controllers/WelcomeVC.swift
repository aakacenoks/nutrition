//
//  WelcomeVC.swift
//  My Nutrition Plan
//
//  Created by Andris Akačenoks on 15/06/2018.
//  Copyright © 2018 Andris Akačenoks. All rights reserved.
//

import UIKit

class WelcomeVC: UIViewController {

    @IBOutlet weak var welcomeGif: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        welcomeGif.loadGif(name: "loading")

        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { // 3 second delay
           self.performSegue(withIdentifier: "GoToAllMeals", sender: self)
        }
    }
}


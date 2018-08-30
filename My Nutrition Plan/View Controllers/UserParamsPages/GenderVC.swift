//
//  GenderVC.swift
//  My Nutrition Plan
//
//  Created by Andris Akačenoks on 15/06/2018.
//  Copyright © 2018 Andris Akačenoks. All rights reserved.
//

import UIKit

class GenderVC: UIViewController {
    
    @IBOutlet var mainView: UIView!
    static var selectedGender: String = ""
    @IBOutlet weak var femaleButton: UIButton!
    @IBOutlet weak var maleButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradientBackground(colorOne: Colors.lightGrey, colorTwo: Colors.white)
        femaleButton.backgroundColor = UIColor.purple
        maleButton.backgroundColor = UIColor.orange
        femaleButton.layer.cornerRadius = 6
        maleButton.layer.cornerRadius = 6
    }

    override func viewDidAppear(_ animated: Bool) {
        if UserParamsVC.paramsEntered{
            self.dismiss(animated: true, completion: nil)
        }
    }

    @IBAction func genderSelected(_ sender: UIButton) {
        if sender.tag == 1{
            GenderVC.selectedGender = "Male"
            femaleButton.backgroundColor = UIColor.lightGray
            maleButton.backgroundColor = UIColor.orange

        }
        else if sender.tag == 2{
            GenderVC.selectedGender = "Female"
            maleButton.backgroundColor = UIColor.lightGray
            femaleButton.backgroundColor = UIColor.purple
        }
    }
}

//
//  AgeVC.swift
//  My Nutrition Plan
//
//  Created by Andris Akačenoks on 15/06/2018.
//  Copyright © 2018 Andris Akačenoks. All rights reserved.
//

import UIKit

class AgeVC: UIViewController {
    @IBOutlet weak var birthdayPicker: UIDatePicker!
    var dateFormatter : DateFormatter!
    var selectedDate: Date!
    static var userAge: Int16!
    @IBOutlet var mainView: UIView!
    
    override func viewDidLoad() {
        view.setGradientBackground(colorOne: Colors.lightGrey, colorTwo: Colors.white)
        super.viewDidLoad()
    }
    
    @IBAction func birthdatDateChanged(_ sender: Any) {
        selectedDate =  birthdayPicker.date
        AgeVC.userAge = getAge()
    }
    
    func getAge() -> Int16{
        return Int16(Calendar.current.dateComponents([.year], from: selectedDate, to: Date()).year!)
    }

}

//
//  HeightVC.swift
//  My Nutrition Plan
//
//  Created by Andris Akačenoks on 15/06/2018.
//  Copyright © 2018 Andris Akačenoks. All rights reserved.
//

import UIKit

class HeightVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var heightAvailable = Array<Int32>(130...250)
    static var selectedHeight: Int32!
    @IBOutlet weak var heightPicker: UIPickerView!
    
    @IBOutlet var mainView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradientBackground(colorOne: Colors.lightGrey, colorTwo: Colors.white)
        heightPicker.delegate = self
        heightPicker.dataSource = self	
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return heightAvailable.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return  String(describing: heightAvailable[row])

    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        HeightVC.selectedHeight = heightAvailable[row]
    }

}

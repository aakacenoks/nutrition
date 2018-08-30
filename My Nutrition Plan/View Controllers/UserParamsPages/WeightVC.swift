//
//  HeightVC.swift
//  My Nutrition Plan
//
//  Created by Andris Akačenoks on 15/06/2018.
//  Copyright © 2018 Andris Akačenoks. All rights reserved.
//

import UIKit

class WeightVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var weightAvailable = Array<Int32>(50...150)
    static var selectedWeight: Int32!
    @IBOutlet weak var weightPicker: UIPickerView!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet var mainView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradientBackground(colorOne: Colors.lightGrey, colorTwo: Colors.white)
        doneButton.layer.cornerRadius = 12
        weightPicker.delegate = self
        weightPicker.dataSource = self
    }
    
    @IBAction func donePressed(_ sender: Any) {
        let user = User(context: PersistenceService.context)
        
        user.gender = GenderVC.selectedGender
        user.age = AgeVC.userAge ?? 0
        user.height =  HeightVC.selectedHeight ?? 0
        user.weight = WeightVC.selectedWeight ?? 0
        
        PersistenceService.saveContext()
        print("User created:")
        print("Gender: \(user.gender ?? "Neutral")")
        print("Age: \(user.age)")
        print("Height: \(user.height)")
        print("Weight: \(user.weight)")
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return weightAvailable.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return  String(describing: weightAvailable[row])
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        WeightVC.selectedWeight = weightAvailable[row]
    }
    
}

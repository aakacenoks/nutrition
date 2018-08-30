//
//  CreateMealVC.swift
//  My Nutrition Plan
//
//  Created by Andris Akačenoks on 30/05/2018.
//  Copyright © 2018 Andris Akačenoks. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class CreateMealVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet var mainVIew: UIView!
    @IBOutlet weak var createButton: UIButton!
    let dbRef: DatabaseReference = Database.database().reference()
    var foodList = Foods()
    var selectedFoodsForDay = [String: String]()
    
    @IBOutlet weak var mealNameLabel: UITextField!
    @IBOutlet weak var mealCountStepper: UIStepper!
    @IBOutlet weak var breakfastPicker: UIPickerView!
    @IBOutlet weak var lunchPicker: UIPickerView!
    @IBOutlet weak var dinnerPicker: UIPickerView!
    @IBOutlet weak var snackPicker: UIPickerView!
    @IBOutlet weak var drinkPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.setGradientBackground(colorOne: Colors.lightGrey, colorTwo: Colors.white)
        createButton.layer.cornerRadius = 12

        selectedFoodsForDay	= ["Name": "",
                                  "Date": "",
                                  foodList.mealTypes[0]: "",
                                  foodList.mealTypes[1]: "",
                                  foodList.mealTypes[2]: "",
                                  foodList.mealTypes[3]: "",
                                  foodList.mealTypes[4]: ""]
        
        breakfastPicker.delegate = self
        lunchPicker.delegate = self
        dinnerPicker.delegate = self
        snackPicker.delegate = self
        drinkPicker.delegate = self

        breakfastPicker.dataSource = self
        lunchPicker.dataSource = self
        dinnerPicker.dataSource = self
        snackPicker.dataSource = self
        drinkPicker.dataSource = self
        
        setFoodNames(ref: dbRef)
        
        breakfastPicker.selectRow(2, inComponent: 0, animated: true)
        lunchPicker.selectRow(2, inComponent: 0, animated: true)
        dinnerPicker.selectRow(2, inComponent: 0, animated: true)
        snackPicker.selectRow(2, inComponent: 0, animated: true)
        drinkPicker.selectRow(2, inComponent: 0, animated: true)

    }

    @IBAction func createButtonPressed(_ sender: Any) {
        selectedFoodsForDay["Name"] = mealNameLabel.text!
        selectedFoodsForDay["Date"] = Helpers.getDateTime()

        dump(selectedFoodsForDay)	// Meal contents

        if selectedFoodsForDay["Name"] != ""{
            let meal = Meal(context: PersistenceService.context)
            
            meal.name             = selectedFoodsForDay["Name"]
            meal.date             = selectedFoodsForDay["Date"]
            meal.breakfastItem    = selectedFoodsForDay["Breakfast"]
            meal.lunchItem        = selectedFoodsForDay["Lunch"]
            meal.dinnerItem       = selectedFoodsForDay["Dinner"]
            meal.snackItem        = selectedFoodsForDay["Snack"]
            meal.drinkItem        = selectedFoodsForDay["Drink"]
            
            PersistenceService.saveContext()
            AllMealsVC.items.append(meal)
            showAlert(titleMsg: "New Meal", msg: "Meal created successfully!", willClose: true)
        }
        else{
            showAlert(titleMsg: "New Meal", msg: "Please name your meal!", willClose: false)
        }
    }
    
    @IBAction func cancelPressed(_ sender: Any) {
        closePopover()
    }
    
    @IBAction func addFoodButtonPressed(_ sender: Any) {
        dump(selectedFoodsForDay)
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == breakfastPicker {
            return foodList.breakfastFoodItems.count
        }
        else if pickerView == lunchPicker{
            return foodList.lunchFoodItems.count
        }
        else if pickerView == dinnerPicker{
            return foodList.dinnerFoodItems.count
        }
        else if pickerView == snackPicker{
            return foodList.snackFoodItems.count
        }
        else if pickerView == drinkPicker{
            return foodList.drinkFoodItems.count
        }
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var label: UILabel
        
        if let view = view as? UILabel{
            label = view
        }
        else{
            label = UILabel()
        }
        label.textAlignment = .center
        label.font = UIFont(name: "Helvetica", size: 12)
        
        if pickerView == breakfastPicker {
            label.text =  foodList.breakfastFoodItems[row]
        }
        else if pickerView == lunchPicker{
            label.text = foodList.lunchFoodItems[row]
        }
        else if pickerView == dinnerPicker{
            label.text = foodList.dinnerFoodItems[row]
        }
        else if pickerView == snackPicker{
            label.text = foodList.snackFoodItems[row]
        }
        else if pickerView == drinkPicker{
            label.text = foodList.drinkFoodItems[row]
        }
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == breakfastPicker {
            selectedFoodsForDay["Breakfast"] = foodList.breakfastFoodItems[row]
        }
        else if pickerView == lunchPicker{
            selectedFoodsForDay["Lunch"] = foodList.lunchFoodItems[row]
        }
        else if pickerView == dinnerPicker{
            selectedFoodsForDay["Dinner"] = foodList.dinnerFoodItems[row]
        }
        else if pickerView == snackPicker{
            selectedFoodsForDay["Snack"] = foodList.snackFoodItems[row]
        }
        else if pickerView == drinkPicker{
            selectedFoodsForDay["Drink"] = foodList.drinkFoodItems[row]
        }
    }
    
    func closePopover(){
        let tmpController :UIViewController! = self.presentingViewController;
        
        self.dismiss(animated: false, completion: {()->Void in
            print("done");
            tmpController.dismiss(animated: false, completion: nil);
        });
    }
    
    func setFoodNames(ref: DatabaseReference){
        for mealTypeItem in foodList.mealTypes{
            ref.child("Meals").child(mealTypeItem).child("Foods").observe(.value) { (snapshot) in
                            let value = snapshot.value as! NSDictionary
                    for (key , _) in value {
                    switch(mealTypeItem){
                    case self.foodList.mealTypes[0]:
                        self.foodList.breakfastFoodItems.append(key as! String)
                        break
                    case self.foodList.mealTypes[1]:
                        self.foodList.lunchFoodItems.append(key as! String)
                        break
                    case self.foodList.mealTypes[2]:
                        self.foodList.dinnerFoodItems.append(key as! String)
                        break
                    case self.foodList.mealTypes[3]:
                        self.foodList.snackFoodItems.append(key as! String)
                        break
                    case self.foodList.mealTypes[4]:
                        self.foodList.drinkFoodItems.append(key as! String)
                        break
                    default:
                        print("Error occured while getting and setting food types")
                    }
                }
                self.breakfastPicker.reloadAllComponents()
                self.lunchPicker.reloadAllComponents()
                self.dinnerPicker.reloadAllComponents()
                self.snackPicker.reloadAllComponents()
                self.drinkPicker.reloadAllComponents()
            }
        }
    }
    override open var shouldAutorotate: Bool {
        return false
    }
    
    func showAlert(titleMsg: String, msg: String, willClose: Bool){
        let alertController = UIAlertController(
            title: titleMsg,
            message: msg,
            preferredStyle: .alert
        )
        let closeButton = UIAlertAction(title: "Close", style: .destructive) { (_) in
            if willClose{
                self.closePopover()
            }
            alertController.dismiss(animated: true)
        }
        alertController.addAction(closeButton)
        self.present(alertController, animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}






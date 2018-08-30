//
//  IndividualMealVC.swift
//  My Nutrition Plan
//
//  Created by Andris Akačenoks on 18/06/2018.
//  Copyright © 2018 Andris Akačenoks. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import CoreData

class IndividualMealVC: UIViewController {
    let dbRef: DatabaseReference = Database.database().reference()
    var meals: Meal!
    var users =  [User]()
    var user: User!

    @IBOutlet var mainVIew: UIView!
    
    var totalCalories: Int = 0
    var totalFat: Int = 0
    var totalCarbs: Int = 0
    var totalProtein: Int = 0
    
    @IBOutlet weak var snackFoodLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var watLabel: UILabel!

    @IBOutlet weak var breakfastFoodLabel: UILabel!
    @IBOutlet weak var lunchFoodLabel: UILabel!
    @IBOutlet weak var dinnerFoodLabel: UILabel!
    @IBOutlet weak var drinkFoodLabel: UILabel!

    @IBOutlet weak var caloriesCountLabel: UILabel!
    @IBOutlet weak var fatCountLabel: UILabel!
    @IBOutlet weak var carbsCountLabel: UILabel!
    @IBOutlet weak var proteinCountLabel: UILabel!
	
	@IBOutlet weak var caloriesIntakeLabel: UILabel!
	@IBOutlet weak var fatIntakeLabel: UILabel!
	@IBOutlet weak var carbsIntakeLabel: UILabel!
	@IBOutlet weak var proteinIntakeLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        do{
            let user = try PersistenceService.context.fetch(fetchRequest)
            self.users = user
            self.user = self.users[0]
            print(self.user.height)
        }
        catch{}
    }
	
	override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.setGradientBackground(colorOne: Colors.lightGrey, colorTwo: Colors.white)

        breakfastFoodLabel.text = meals.breakfastItem
        lunchFoodLabel.text = meals.lunchItem
        dinnerFoodLabel.text = meals.dinnerItem
        snackFoodLabel.text = meals.snackItem
        drinkFoodLabel.text = meals.drinkItem
        
        getFoodStats(ref: dbRef)
    }
    
    func setFoodCalories(){
        caloriesCountLabel.text = String(self.totalCalories)
        fatCountLabel.text = String(self.totalFat)
        carbsCountLabel.text = String(self.totalCarbs)
        proteinCountLabel.text = String(self.totalProtein)
    }
    
    func setIntakePercentage(){
        caloriesIntakeLabel.text = "\(String(getCalorieIntakePercentage()))%*"
        fatIntakeLabel.text = "\(String(getFatIntakePercentage()))%*"
        carbsIntakeLabel.text = "\(String(getCarbsIntakePercentage()))%*"
        proteinIntakeLabel.text = "\(String(getProteinIntakePercentage()))%*"
    }
    
    func getFoodStats(ref: DatabaseReference){
        ref.child("Meals").observe(.value) { (snapshot) in
            let value = snapshot.value as! NSDictionary
            self.setStatsForSelectedBreakfast(mealsDictionary: value)
            self.setStatsForSelectedLunch(mealsDictionary: value)
            self.setStatsForSelectedDinner(mealsDictionary: value)
            self.setStatsForSelectedSnack(mealsDictionary: value)
            self.setStatsForSelectedDrink(mealsDictionary: value)
                
            self.setFoodCalories()
            self.setIntakePercentage()
        }
    }
    
    // Breakfast
    func setStatsForSelectedBreakfast( mealsDictionary: NSDictionary){
        let breakfastItem = meals.breakfastItem
        let underBreakfast = mealsDictionary["Breakfast"] as! NSDictionary
        let underFoods = underBreakfast["Foods"] as! NSDictionary
        let underItem = underFoods[breakfastItem!] as! NSDictionary
        totalCalories = totalCalories + (underItem["Calories"] as! Int)
        totalFat = totalFat + (underItem["Fat"] as! Int)
        totalCarbs = totalCarbs + (underItem["Carbohydrates"] as! Int)
        totalProtein = totalProtein + (underItem["Protein"] as! Int)
    }
    
    // Lunch
    func setStatsForSelectedLunch( mealsDictionary: NSDictionary){
        let lunchItem = meals.lunchItem
        let underLunch = mealsDictionary["Lunch"] as! NSDictionary
        let underFoods = underLunch["Foods"] as! NSDictionary
        let underItem = underFoods[lunchItem!] as! NSDictionary
        totalCalories = totalCalories + (underItem["Calories"] as! Int)
        totalFat = totalFat + (underItem["Fat"] as! Int)
        totalCarbs = totalCarbs + (underItem["Carbohydrates"] as! Int)
        totalProtein = totalProtein + (underItem["Protein"] as! Int)
    }
    
    // Dinner
    func setStatsForSelectedDinner( mealsDictionary: NSDictionary){
        let dinnerItem = meals.dinnerItem
        let underDinner = mealsDictionary["Dinner"] as! NSDictionary
        let underFoods = underDinner["Foods"] as! NSDictionary
        let underItem = underFoods[dinnerItem!] as! NSDictionary
        totalCalories = totalCalories + (underItem["Calories"] as! Int)
        totalFat = totalFat + (underItem["Fat"] as! Int)
        totalCarbs = totalCarbs + (underItem["Carbohydrates"] as! Int)
        totalProtein = totalProtein + (underItem["Protein"] as! Int)
    }
    
    // Snack
    func setStatsForSelectedSnack( mealsDictionary: NSDictionary){
        let snackItem = meals.snackItem
        let underSnack = mealsDictionary["Snack"] as! NSDictionary
        let underFoods = underSnack["Foods"] as! NSDictionary
        let underItem = underFoods[snackItem!] as! NSDictionary
        totalCalories = totalCalories + (underItem["Calories"] as! Int)
        totalFat = totalFat + (underItem["Fat"] as! Int)
        totalCarbs = totalCarbs + (underItem["Carbohydrates"] as! Int)
        totalProtein = totalProtein + (underItem["Protein"] as! Int)
    }
    
    // Drink
    func setStatsForSelectedDrink( mealsDictionary: NSDictionary){
        let drinkItem = meals.drinkItem
        let underDrink = mealsDictionary["Drink"] as! NSDictionary
        let underFoods = underDrink["Foods"] as! NSDictionary
        let underItem = underFoods[drinkItem!] as! NSDictionary
        totalCalories = totalCalories + (underItem["Calories"] as! Int)
    }
    
    func getLbs(kilos: Double) -> Double{
        return (kilos * 2.2)
    }
    
    func getInches(cm: Double) -> Double{
        return cm / 2.54
    }
    
    func getRecommendedCalories() -> Int{
        let age = Double(self.user.age)
        let height = getInches(cm: Double(self.user.height))
        let weight = getLbs(kilos: Double(self.user.weight))
        let isMale: Bool = ((self.user.gender) == "Male") ? true : false
        
        var metabolicRate: Double = 0
        let activityFactor: Double = 1.375
        
        if isMale{
            metabolicRate = (weight * 6.23)
            metabolicRate =  metabolicRate + (height * 12.7)
            metabolicRate =  metabolicRate - (age / 6.8) + 66
        }
        else{
            metabolicRate = (weight * 4.35)
            metabolicRate =  metabolicRate + (height * 4.7)
            metabolicRate =  metabolicRate - (age / 4.7) + 655
        }
        return Int(floor(metabolicRate * activityFactor))
    }
    
    func getCalorieIntakePercentage() -> Int{
        return Int((Double(self.totalCalories))/Double(getRecommendedCalories()) * 100)
    }
    
    func getFatIntakePercentage() -> Int{
        let caloriesFromFat = self.totalFat * 9
        return Int((Double(caloriesFromFat) / (Double(getRecommendedCalories())*0.3)) * 100)
    }
    
    func getCarbsIntakePercentage() -> Int{
        let caloriesFromCarbs = self.totalCarbs * 4
        return Int((Double(caloriesFromCarbs) / (Double(getRecommendedCalories())*0.55)) * 100)
    }
    
    func getProteinIntakePercentage() -> Int{
        let caloriesFromProtein = self.totalProtein * 4
        return Int((Double(caloriesFromProtein) / (Double(getRecommendedCalories())*0.15)) * 100)
    }
}




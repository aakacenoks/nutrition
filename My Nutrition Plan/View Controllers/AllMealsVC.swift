//
//  AllMealsVC.swift
//  My Nutrition Plan
//
//  Created by Andris Akačenoks on 13/06/2018.
//  Copyright © 2018 Andris Akačenoks. All rights reserved.
//

import UIKit
import CoreData

class AllMealsVC: UIViewController {
    @IBOutlet weak var allMealsTableView: UITableView!
    
    @IBOutlet var mainView: UIView!
    static var items = [Meal]()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.allMealsTableView.backgroundColor = Colors.lightGrey
        self.navigationItem.setHidesBackButton(true, animated:true);
        allMealsTableView.tableFooterView = UIView(frame: CGRect.zero)
        allMealsTableView.delegate = self
        allMealsTableView.dataSource = self
        
        let fetchRequest: NSFetchRequest<Meal> = Meal.fetchRequest()
        do{
            let items = try PersistenceService.context.fetch(fetchRequest)
            AllMealsVC.self.items = items
            allMealsTableView.reloadData()
        }
        catch{}
        print(AllMealsVC.items.count)
        
        if AllMealsVC.items.count > 0 {
            self.allMealsTableView.isHidden = false
            print(AllMealsVC.items[0].date!)
            print(AllMealsVC.items[0].name!)
        }
        else{
            self.allMealsTableView.isHidden = true
        }
        dump(AllMealsVC.items)
        allMealsTableView.reloadData()
    }
}

extension AllMealsVC: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AllMealsVC.items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "MealCell")
        cell.textLabel?.text = AllMealsVC.items[indexPath.row].name
        cell.detailTextLabel?.text = "Created on \(AllMealsVC.items[indexPath.row].date ?? "0000-00-00 00:00:00")"
        cell.accessoryType = .disclosureIndicator

        return cell
    }
    
   func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
       if editingStyle == UITableViewCellEditingStyle.delete{
        
           let fetchRequest: NSFetchRequest<Meal> = Meal.fetchRequest()
           do {
               let objects = try PersistenceService.context.fetch(fetchRequest)
               for object in objects {
                   if object == AllMealsVC.items[indexPath.row]{
                       PersistenceService.context.delete(object)
                   }
               }
               try PersistenceService.context.save()
           } catch _ {}
        
           AllMealsVC.items.remove(at: indexPath.row)
           allMealsTableView.reloadData()
            if AllMealsVC.items.count < 1 {
                self.allMealsTableView.isHidden = true
            }
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showIndividual", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? IndividualMealVC {
            destination.meals = AllMealsVC.items[(allMealsTableView.indexPathForSelectedRow?.row)!]
        }
    }
    
}


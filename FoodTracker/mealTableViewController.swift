//
//  @Name: mealTableViewController.swift
//  @Purpose: To load data onto the table views
//  FoodTracker
//
//  Created by Pratheeksha Ravindra Naik on 2018-09-28.
//  Copyright © 2018 com/uregina. All rights reserved.
//

import os.log
import UIKit

class mealTableViewController: UITableViewController {
    
    //MARK: Properties
    
    
    var meals = [Meal]()  //default value initialized

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //use the edit button item provided by the table view controller.
        navigationItem.leftBarButtonItem = editButtonItem
        
            // Load any saved meals, otherwise load sample data.
        if let savedMeals = loadMeals() {
            meals += savedMeals
        }else {
            // Load the sample data.
            loadSampleMeals()
        }
    }

    // MARK: - Table view data source

    /*
     Function to load the data.
     Takes UITableView and an integer indicating the number of Rows and returns the count
     */
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    /*
     Function to inform the table in how many rows to display in the given section to load the data.
     Takes UITableView and an integer indicating the number of Rows and returns the count
     */
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return meals.count    //the total number of meals that we created i.e. 5; that many rows to be displayed
    }

    //Requests a cell from table view specially when scrolling thorugh the app
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "MealTableViewCell"
        
        //downcasting it because of custome cell class creation
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier,
                                                       for: indexPath) as? MealTableViewCell else {
                                                        fatalError("The dequeued cell is not an instance of MealTableViewCell")
        }

        //fetches the appropriate meal for the data source layot
        let meal = meals[indexPath.row]
        
        cell.nameLabel.text = meal.name
        cell.photoImageView.image = meal.photo
        cell.ratingControl.rating = meal.rating
        
        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        //nothing
        return true
    }
 

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            meals.remove(at: indexPath.row)
            saveMeals()                                           //saving the meals whenever created
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
       super.prepare(for: segue, sender: sender)  //A call to superclass's implementation
        
        switch(segue.identifier ?? "") {
            
        case "AddItem":
            os_log("Adding a new meal.", log: OSLog.default, type: .debug)
            
        case "showDetail":
            guard let mealDetailViewController = segue.destination as? MealViewController
                else {
                    fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedMealCell = sender as? MealTableViewCell else {
                fatalError("Unexpected sender: \(sender)")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedMealCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedMeal = meals[indexPath.row]
            mealDetailViewController.meal = selectedMeal
            
        default:
            fatalError("Unexpected Segue Identifier; \(segue.identifier)")
        }
    }
    
    
    //MARK: Actions
    
    @IBAction func unwindToMealList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? MealViewController, let meal =
            sourceViewController.meal {
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                //Update an existing meal
                meals[selectedIndexPath.row] = meal
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
            else {
            //Add a new Meal
            let newIndexPath = IndexPath(row: meals.count, section: 0) //computes location in table view where the new table view cell represents new meal
            
            meals.append(meal) // adds the new meal
            
            tableView.insertRows(at: [newIndexPath], with: .automatic)  
           }
            
            //save the meals
            saveMeals()
        }
            
        }
    

    //MARK: private Methods
    
    //Function to load data to the app - the image, name of the food and the rating.
    
    private func loadSampleMeals() {
        
        let photo1 = UIImage(named: "Meal1")
        let photo2 = UIImage(named: "Meal2")
        let photo3 = UIImage(named: "Meal3")
        let photo4 = UIImage(named: "Meal4")
        let photo5 = UIImage(named: "Meal5")
        let photo6 = UIImage(named: "Meal6")
        let photo7 = UIImage(named: "Meal7")
        
        guard let Meal1 = Meal(name: "Shrimp Sushi", photo: photo1, rating: 3) else {
            fatalError("Unable to instantiate Meal1")
        }
        
        guard let Meal2 = Meal(name: "Garlic Naan ", photo: photo2, rating: 5) else {
            fatalError("Unable to instantiate Meal2")
        }
        
        guard let Meal3 = Meal(name: "Mexicana Taco", photo: photo3, rating: 4) else {
            fatalError("Unable to instantiate Meal3")
        }
        
        guard let Meal4 = Meal(name: "Thai Red Curry Rice", photo: photo4, rating: 5) else {
            fatalError("Unable to instantiate Meal4")
        }
        
        guard let Meal5 = Meal(name: "Italian Pasta", photo: photo5, rating: 3) else {
            fatalError("Unable to instantiate Meal5")
        }
        
        guard let Meal6 = Meal(name: "Chicken Chopsuey", photo: photo6, rating: 2) else {
            fatalError("Unable to instantiate Meal6")
            
        }
        
        guard let Meal7 = Meal(name: "Burger with Fries", photo: photo7, rating: 4) else {
            fatalError("Unable to instantiate Meal7")
        }
        
        //adding them all to the array
        meals += [Meal1, Meal2, Meal3, Meal4, Meal5, Meal6, Meal7]
        
    }
    
    private func saveMeals() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(meals, toFile: Meal.ArchiveURL.path)
        
        if isSuccessfulSave {
            os_log("Meals successfully saved.", log: OSLog.default, type: .debug)
        }else {
            os_log("Failed to save meals...", log: OSLog.default, type: .error)
        }
    }
    
    //returns type of optional array objects
    private func loadMeals() -> [Meal]? {
        
        return NSKeyedUnarchiver.unarchiveObject(withFile: Meal.ArchiveURL.path) as? [Meal]
        
    }
    
}

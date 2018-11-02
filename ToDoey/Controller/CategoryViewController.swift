//
//  CategoryViewController.swift
//  ToDoey
//
//  Created by Paul Raymond on 11/2/18.
//  Copyright © 2018 Paul Raymond. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    var categories = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var textField = UITextField()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
        saveCategories()

    }

    // MARK: - Table view data source

     override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
       return categories.count
   }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        let item = categories[indexPath.row]
        
        cell.textLabel?.text = item.name
        
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories[indexPath.row]
        }
    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }


    @IBAction func AddButtonPressed(_ sender: UIBarButtonItem) {
        
       // var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            
        let newCategory = Category(context: self.context)
            
            newCategory.name = self.textField.text!
            self.categories.append(newCategory)
//            newItem.done = false
//
//            self.categories.append(newItem)
            
            self.saveCategories()
            
        }
        //what will happen once the user adds a new item
         alert.addAction(action)
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Add a New Category"
            self.textField = alertTextField
        }
        
        
        present(alert, animated: true, completion: nil)
        
        
    }
    
    func saveCategories() {
        
        do {
            
            try context.save()
            
        } catch {
            
            print("Error Saving Context, \(error)")
            
        }
        
        self.tableView.reloadData()
    }
    
    func loadCategories(with request: NSFetchRequest<Category> = Category.fetchRequest()) {
        
        do {
            categories = try context.fetch(request)
        } catch {
            print("Error Loading Categories \(error)")
        }
        tableView.reloadData()
    }
    
}

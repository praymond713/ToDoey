//
//  CategoryViewController.swift
//  ToDoey
//
//  Created by Paul Raymond on 11/2/18.
//  Copyright © 2018 Paul Raymond. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {
    
    let realm = try! Realm()
    
    var categories: Results<Category>?
    var textField = UITextField()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
        

    }

    // MARK: - Table view data source

     override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        //nill coelesence
        
       return categories?.count ?? 1
   }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Categories added yet"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToItems", sender: self)
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! ToDoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }



    @IBAction func AddButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
        let newCategory = Category()
            
            newCategory.name = textField.text!
            
            self.save(category: newCategory)
            
        }
        
        //what will happen once the user adds a new item
         alert.addAction(action)
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Add a New Category"
            textField = alertTextField
            textField.placeholder = "Add New Category"
        }
        
        
        present(alert, animated: true, completion: nil)
        
        
    }

    
    func save(category: Category) {
        
        do {
            
            try realm.write {
                realm.add(category)
            }
            
        } catch {
            
            print("Error Saving Context, \(error)")
            
        }
        
        tableView.reloadData()
    }
    
   func loadCategories() {
    
    
        categories = realm.objects(Category.self)
    
    
        tableView.reloadData()
   }
    
}

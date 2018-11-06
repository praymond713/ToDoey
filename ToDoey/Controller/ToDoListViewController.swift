//
//  ViewController.swift
//  ToDoey
//
//  Created by Paul Raymond on 10/22/18.
//  Copyright © 2018 Paul Raymond. All rights reserved.
//

import UIKit
import RealmSwift

class ToDoListViewController: UITableViewController {
    
    var toDoItems: Results<Item>?
    let realm = try! Realm()
    var selectedCategory : Category? {
        didSet{
            loadItems()
        }
    }
    
    var textField = UITextField()


    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return toDoItems?.count ?? 1
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        if let item = toDoItems?[indexPath.row] {
            
            cell.textLabel?.text = item.title
            
            //ternary operator
            //value = condition ? valueIftrue : valueIfFalse
            cell.accessoryType = item.done ? .checkmark : .none
            
            
        } else {
            cell.textLabel?.text = "No Items Added"
        }
        
       
                
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let item = toDoItems?[indexPath.row] { //checks to see if nill with the ?
            do {
                try realm.write {
     //               realm.delete(item)
                   item.done = !item.done
                }
            } catch {
                print("Error saving done status, \(error)")
            }
        }
        tableView.reloadData()
        
//        toDoItems[indexPath.row].done = !toDoItems[indexPath.row].done
       
//        saveitems()
//        
        tableView.deselectRow(at: indexPath, animated: true)
    }

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            if let currentCategory = self.selectedCategory {
                do {
                    try self.realm.write {
                        let newItem = Item()
                        newItem.title = textField.text!
                        newItem.dateCreated = Date()
                        currentCategory.items.append(newItem)
                    }
                } catch {
                    print("Error saving new Items, \(error)")
                
                }
            }
            
            self.tableView.reloadData()
            
        }
            //what will happen once the user adds a new item
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Creat new Item"
            textField = alertTextField
        }
            
            alert.addAction(action)
            
            present(alert, animated: true, completion: nil)
            
        
    }
    
    
    
    
    func loadItems() {
        
        
        toDoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)

//        let categorypredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
//
//        if let additionalPredicate = predicate{
//            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categorypredicate, additionalPredicate])
//        } else {
//            request.predicate = categorypredicate
//        }
//
//
//        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categorypredicate, predicate])
//        request.predicate = compoundPredicate
//
//        do {
//        itemArray = try context.fetch(request)
//        } catch {
//            print("Error fetching data from contect \(error)")
//        }
        tableView.reloadData()
    }
}
//MARK: Searchbar Methods

extension ToDoListViewController: UISearchBarDelegate {
    
    

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        toDoItems = toDoItems?.filter("title CONTAINS[CD] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        
        tableView.reloadData()
    }
    



    

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()
            DispatchQueue.main.async{

              searchBar.resignFirstResponder()
            }


        }
    }
}

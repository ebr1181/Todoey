//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Ernesto Ruiz on 9/21/19.
//  Copyright © 2019 Ernesto Ruiz. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift

class CategoryViewController: UITableViewController {
    
    let realm = try! Realm()
    
    var categoryArray: Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()
    }

   
    @IBAction func addButton(_ sender: Any) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add Category", message: "", preferredStyle: .alert)
        
        alert.addTextField { (alertField) in
            alertField.placeholder = "Create new Category"
            textField = alertField
        }
    
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            let newCategory = Category()
            newCategory.name = textField.text!
           
            
            self.save(category: newCategory)
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    //MARK - TableView DataSource Methods
    
  
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)

        cell.textLabel?.text = categoryArray?[indexPath.row].name ?? "No categories added yet"
        
        
       return cell
    }
    

    
    //MARK - TableView Delegate Methods
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray?.count ?? 1
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            let selectedCategoryRow = categoryArray?[indexPath.row]
            destinationVC.selectedCategory = selectedCategoryRow
            
        }
        
    }
    
    
    
    //MARK - TableView Data Manipulation Methods
    func save(category: Category)
      {
          do {
            try realm.write {
                realm.add(category)
            }
          } catch  {
              print(error)
          }
          tableView.reloadData()
      }
      
      
      func loadCategories(){
         
        categoryArray = realm.objects(Category.self)

         
          tableView.reloadData()
      }
}

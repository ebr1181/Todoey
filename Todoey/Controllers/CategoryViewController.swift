//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Ernesto Ruiz on 9/21/19.
//  Copyright © 2019 Ernesto Ruiz. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {

    var categoryArray = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
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
            
            let category = Category(context: self.context)
            category.name = textField.text!
            self.categoryArray.append(category)
            
            self.saveCategories()
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    //MARK - TableView DataSource Methods
    
  
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
        let category = categoryArray[indexPath.row]
        
        cell.textLabel?.text = category.name
        cell.accessoryType =  ((category.items?.count)! >  0) ? .disclosureIndicator : .none
        
       return cell
    }
    

    
    //MARK - TableView Delegate Methods
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            let selectedCategoryRow = categoryArray[indexPath.row]
            destinationVC.selectedCategory = selectedCategoryRow
            print(categoryArray[indexPath.row])
        }
        
    }
    
    
    
    //MARK - TableView Data Manipulation Methods
    func saveCategories()
      {
          do {
              try context.save()
          } catch  {
              print(error)
          }
          tableView.reloadData()
      }
      
      
      func loadCategories(with request:NSFetchRequest<Category> = Category.fetchRequest()){
          
          do {
              categoryArray = try context.fetch(request)
          } catch {
              print(error)
          }
          tableView.reloadData()
      }
}

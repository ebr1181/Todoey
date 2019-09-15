//
//  ViewController.swift
//  Todoey
//
//  Created by Ernesto Ruiz on 9/13/19.
//  Copyright © 2019 Ernesto Ruiz. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = [Item]()
    let arrayKey = "TodoListArray"
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadItems()
        
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        let item = itemArray[indexPath.row]
    
        cell.textLabel?.text = item.title
        cell.accessoryType = (item.done) ? .checkmark : .none
        
    
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        itemArray[indexPath.row].done = !itemArray[indexPath.row].done

        saveItems()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
           let item = Item(itemTitle: textField.text!, Iscompleted: false)
            
            self.itemArray.append(item)
            self.saveItems()

        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func saveItems() {
        let encoder = PropertyListEncoder()
        
        do {
            let dataToBeEncoded = try encoder.encode(itemArray)
            try dataToBeEncoded.write(to: dataFilePath!)
        } catch  {
            print("error: \(error)")
        }
        tableView.reloadData()
    }
    
    func loadItems()  {
        
        if let data = try? Data(contentsOf: dataFilePath!){
            
            let decoder = PropertyListDecoder()
            
            do {
                itemArray = try decoder.decode([Item].self, from: data)
            } catch  {
                print("error: \(error)")
            }
            
        }
    }
}

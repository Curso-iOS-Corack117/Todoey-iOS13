//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    let defaults = UserDefaults.standard
    var itemArray: [Item] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("viewDidLoad")
        if let items = defaults.array(forKey: "ToDoListArray") as? [Item] {
            itemArray = items
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        var cellConfig = cell.defaultContentConfiguration()
        cellConfig.text = itemArray[indexPath.row].name
        cell.contentConfiguration = cellConfig
        return cell
    }
    
    //MARK: - TablewView Delegate Method
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = cell?.accessoryType == .checkmark ? .none : .checkmark
    }
    
    //MARK: - Add new Items
    @IBAction func addNewItem(_ sender: Any) {
        var newItemTextField = UITextField()
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { action in
            if !newItemTextField.text!.isEmpty {
                let item = Item(name: newItemTextField.text!)
                self.itemArray.append(item)
                self.defaults.set(self.itemArray, forKey: "ToDoListArray")
                self.tableView.reloadData()
            }
        }
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Create new item"
            newItemTextField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true)
    }
}

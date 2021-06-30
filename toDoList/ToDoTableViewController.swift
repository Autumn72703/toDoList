//
//  ToDoTableViewController.swift
//  toDoList
//
//  Created by Autumn Halfpenny on 6/28/21.
//

import UIKit

class ToDoTableViewController: UITableViewController {

    var toDos : [ToDoCD] = []
    
    override func viewDidLoad(){
        super.viewDidLoad()
    }
        
    func getToDos() {
        
          if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            
            if let coreDataToDos = try? context.fetch(ToDoCD.fetchRequest()) as? [ToDoCD] {
                    //if let theToDos = coreDataToDos {
                        toDos = coreDataToDos
                        tableView.reloadData()
                    //}
                }

          }
        }
 
    
    override func viewWillAppear(_ animated: Bool) {
      getToDos()
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return toDos.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        let toDo = toDos[indexPath.row]
        
        if let name = toDo.name {
          if toDo.important {
              cell.textLabel?.text = "❗️" + name
          } else {
              cell.textLabel?.text = toDo.name
          }
        }
        
 /*       if toDo.important {
            cell.textLabel?.text = "❗️" + toDo.name
          } else {
            cell.textLabel?.text = toDo.name
          }*/
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

      // this gives us a single ToDo
      let toDo = toDos[indexPath.row]

      performSegue(withIdentifier: "moveToComplete", sender: toDo)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let addVC = segue.destination as? AddToDoViewController {
            addVC.previousVC = self
          }
        if let completeVC = segue.destination as? CompleteToDoViewController {
            if let toDo = sender as? ToDoCD {
              completeVC.selectedToDo = toDo
              completeVC.previousVC = self
            }
          }
        
    }
    

}

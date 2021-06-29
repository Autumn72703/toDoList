//
//  ToDoTableViewController.swift
//  toDoList
//
//  Created by Autumn Halfpenny on 6/28/21.
//

import UIKit

class ToDoTableViewController: UITableViewController {

    var toDos : [ToDo] = []
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        toDos = createToDos()
    }

    // MARK: - Table view data source
    func createToDos() -> [ToDo] {

      let swift = ToDo()
      swift.name = "Learn Swift"
      swift.important = true

      let dog = ToDo()
      dog.name = "Walk the Dog"

      return [swift, dog]
    }
    /*
    override func numberOfSections(in tableView: UITableView) -> Int {

        return 0
    }*/

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return toDos.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        let toDo = toDos[indexPath.row]
        
        if toDo.important {
            cell.textLabel?.text = "❗️" + toDo.name
          } else {
            cell.textLabel?.text = toDo.name
          }
        
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
            if let toDo = sender as? ToDo {
              completeVC.selectedToDo = toDo
              completeVC.previousVC = self
            }
          }
    }
    

}

//
//  ViewController.swift
//  CoreDataPractice
//
//  Created by Zoom Digital on 11/08/2021.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK:- Variables
    @IBOutlet weak var tableView: UITableView!
    var items: [Person]?
    
    var isAdd: Bool = true
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        fetchPeople()
    }
    
    
    //MARK:- Actions
    @IBAction func addBtn(_ sender: Any) {
        AddUser(title: "Add People", description: "Please Type The Name", btnText: "Add")
        
    }
    
    func fetchPeople() {
        do{
            
            self.items = try context.fetch(Person.fetchRequest())
            DispatchQueue.main.async{
                self.tableView.reloadData()
            }
        } catch {
            
        }
        
    }
    
    func AddUser(title: String, description: String, btnText: String)  {
        
        let alert = UIAlertController(title: title, message: description, preferredStyle: .alert)
        alert.addTextField()
        // button configuration to alert
      
        let addBtn = UIAlertAction(title: btnText, style: .default) { (action) in
            // Grab the value from textfield
            let textField = alert.textFields![0]
                // Create Person Object and assign values
                let personObject = Person(context: self.context)
                
                // Assign Values to the object
                personObject.name = textField.text
                personObject.age = 16
                personObject.gender = "Male"
          
           
            // Save the created object to core data
                do{
                    try
                        self.context.save()
                }catch{
                    
                }
         
            // Re-fetch the data to display on tableview
            self.fetchPeople()
        }
        // Add Action to Alert Button
        alert.addAction(addBtn)
        
        //Show the Alert
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func UpdateUser(title: String, nameOfPerson: Person)  {
        
        let alert = UIAlertController(title: title, message: "", preferredStyle: .alert)
        alert.addTextField()
        // button configuration to alert
      
        let addBtn = UIAlertAction(title: "Save", style: .default) { (action) in
            // Grab the value from textfield
          
            let textField = alert.textFields![0]
                // Create Person Object and assign values
            
                // Assign Values to the object
            nameOfPerson.name = textField.text
          
           
            // Save the created object to core data
                do{
                    try
                        self.context.save()
                }catch{
                    
                }
         
            // Re-fetch the data to display on tableview
            self.fetchPeople()
        }
        // Add Action to Alert Button
        alert.addAction(addBtn)
        
        //Show the Alert
        self.present(alert, animated: true, completion: nil)
    }
    
}


//MARK:- Extensions
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                return items!.count
//        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "DataTableViewCell") as? DataTableViewCell{
            
            let person = self.items![indexPath.row]
            cell.nameLbl?.text = person.name
            //            cell.nameLbl?.text = "person.name"
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let person = self.items![indexPath.row]
        
        UpdateUser(title: "Please Update The Field", nameOfPerson: person)
    }
    
    // Add Swipe Left Action
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete") { action, view, completionhandler in
            
            // on swipe Which Person to Be Removed
            let personToRemove = self.items![indexPath.row]
            
            // Remove the selected person
            
            self.context.delete(personToRemove)
            
            // save the data again updated
            do{
                try
                    self.context.save()
            }catch{
                
            }
            
            // re-fetch the updated data
            self.fetchPeople()
            
            
        }
        
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    
    
    
}


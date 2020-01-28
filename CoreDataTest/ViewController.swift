//
//  ViewController.swift
//  CoreDataTest
//
//  Created by Md Maruf Prodhan on 1/23/20.
//  Copyright © 2020 Md Maruf Prodhan. All rights reserved.
//

import UIKit
import CoreData


class ViewController: UIViewController{
    
 
    //@IBOutlet weak var showdelete: UIButton!
    @IBOutlet weak var showDataTextView: UITextView!
    @IBOutlet weak var nameTextView: UITextField!
    @IBOutlet weak var ageTextView: UITextField!
    
    @IBOutlet weak var delettxt: UITextField!
    
    
   
    
    var textFieldString : String = ""
    var people = [People]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        showAllPerson()
        
        
        
    }

    @IBAction func deletebtn(_ sender: Any) {
        deleteData()
        showAllPerson()
    }
    
        
        func deleteData(){
            
            let managedContext = PersistenceService.persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "People")
            
          
            let deletePerson = delettxt.text
            
            
            // fetch the person to delete
            fetchRequest.predicate = NSPredicate(format: "name = %@", deletePerson!)
            
            do{
                let people = try managedContext.fetch(fetchRequest)
                
                for person in people{
                    let objectToDelete = person as! NSManagedObject
                    managedContext.delete(objectToDelete)
                }
                
                print("Deleted item : ", people)
                
                do{
                    try managedContext.save()
                }
                catch{
                    print(error)
                }
            } catch {
                print(error)
                
            }
        }
        
        
        
        
        
    
    @IBAction func addButtonTapped(_ sender: Any) {
        let name = nameTextView.text
        let age = ageTextView.text
        
        print(name as Any)
        print(age as Any)
        
        let person = People(context: PersistenceService.context)
        person.name = name
        person.age = Int16(age!)!
        PersistenceService.saveContext()
        print("From DB - ")
        showAllPerson()
        
    }
    
    
    
    
    
    
    
    
    
    
    
    // Function for fetching and showing data
    func showAllPerson() {
        
        textFieldString = ""
        let fetchRequest : NSFetchRequest<People> = People.fetchRequest()
        
        do {
            let people = try PersistenceService.context.fetch(fetchRequest)
            self.people = people
            for item in people {
                print("Name: \(item.name as Any) \nAge: \(item.age as Any)")
                
                // Appending to the string
                self.textFieldString += "Name: " + item.name! + ": " + "Age: " + String(item.age) + "\n"
            }
            
            // Show in textview
            showDataTextView.text = textFieldString
            
        } catch {
            print("Failed to fetch")
        }
    }
    
    
    

}



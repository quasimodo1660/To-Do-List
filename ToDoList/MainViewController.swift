//
//  ViewController.swift
//  ToDoList
//
//  Created by Peisure on 1/18/18.
//  Copyright © 2018 Ben. All rights reserved.
//

import UIKit
import CoreData

class MainViewController: UITableViewController, AddViewControllerDelegate {
    
    var items = [ToDoList]()
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
   
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let AddViewController = segue.destination as! AddViewController
        AddViewController.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAllItems()
//        remove()
        print(items.count)
        tableView.contentInset = UIEdgeInsetsMake(20.0, 0.0, 0.0, 0.0)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44
        tableView.reloadData()
        // Do any additional setup after loading the view, typically from a nib.
    }

//    func remove(){
//        let item = items.removeLast()
//
//        managedObjectContext.delete(item)
//        do{
//            try managedObjectContext.save()
//        }
//        catch{
//            print("\(error)")
//        }
//    }
    
   
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for:indexPath) as! CustomCell
        if items.count != 0{
            cell.totitleLabel.text = items[indexPath.row].title
            let formatter = DateFormatter()
            formatter.dateFormat = "MM/dd/yyyy"
            let myDate = items[indexPath.row].biginDate
            cell.tododateLabel.text = formatter.string(from: myDate!)
            cell.contentLable.text = items[indexPath.row].content
            if items[indexPath.row].mark == true{
                cell.accessoryType = .checkmark
            }
        }
        return cell
    }
    
    
    func addItem(_ controller: AddViewController, with title: String, _ content: String, and date: Date) {
        let item = NSEntityDescription.insertNewObject(forEntityName: "ToDoList", into: managedObjectContext) as! ToDoList
        print(title,content,date)
        item.title = title
        item.content = content
        item.biginDate = date
        item.mark = false
        items.append(item)
        do{
            try managedObjectContext.save()
        }
        catch{
            print("\(error)")
        }
        dismiss(animated: true, completion: nil)
        tableView.reloadData()
    }
    func fetchAllItems(){
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ToDoList")
        do{
            let result = try managedObjectContext.fetch(request)
            items = result as! [ToDoList]
        }
        catch{
            print("\(error)")
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        let item = items[indexPath.row]
        item.mark = true
        do{
            try managedObjectContext.save()
        }
        catch{
            print("\(error)")
        }
        tableView.reloadData()
    }
    
    
}


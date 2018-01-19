//
//  AddViewController.swift
//  ToDoList
//
//  Created by Peisure on 1/18/18.
//  Copyright © 2018 Ben. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {
    
    @IBOutlet weak var toDoTitle: UITextField!
    @IBOutlet weak var toDoContent: UITextField!
    @IBOutlet weak var toDoDate: UIDatePicker!
    
    var delegate: AddViewControllerDelegate?
    
    
   
    
    @IBAction func addItemButton(_ sender: UIButton) {
        delegate?.addItem(self, with: toDoTitle.text!, toDoContent.text!, and: toDoDate.date)
    }
    
   

}

protocol AddViewControllerDelegate: class {
    func addItem(_ controller: AddViewController, with title:String, _ content:String, and date:Date)
}

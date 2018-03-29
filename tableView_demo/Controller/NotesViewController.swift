//
//  ViewController.swift
//  Note it!
//  Created by Henrik on 2018-03-26.
//  Copyright © 2018 Henrik. All rights reserved.
//

import UIKit
import Firebase

class NotesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    let protoCell = "protoCell"
    var notesArray = [Notes]()
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        tableView.delegate = self
//        tableView.dataSource = self
        ref = Database.database().reference()
//        ref.child("users").child("001").setValue(["username":"david" ])
        print("hit har vi kommit..")
        
        
    }

    func noteEntry(){
//        let note = Notes(content: "texten är här", completed: false)
//        ref.child("items").childByAutoId().setValue(note)
        
    }
    
    
    


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: protoCell, for: indexPath)
        
        if let label = cell.textLabel {
            label.text = "Hej"
            label.text = notesArray[indexPath.row].content
        }
        
        return cell
    }
 
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


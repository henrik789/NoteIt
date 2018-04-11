//
//  ViewController.swift
//  Note it!
//  Credits    https://www.freepik.com/free-vector/abstract-design-background_1366169.htm"
//  Created by Henrik on 2018-03-26.
//  Copyright © 2018 Henrik. All rights reserved.
//

import UIKit
import Firebase

class NotesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var noteTableView: UITableView!
    @IBAction func composeButton(_ sender: Any) {
        print("hej!")
    }
    let noteContent = ["Första inlägget", "Morbi sed rutrum felis. Suspendisse rutrum est mollis, sollicitudin nunc ac, blandit neque.", "Tredje inlägget"]
    let noteNumber = ["1", "2", "3"]
    
    let newNote = Notes(content: "Hej")
    let notesCell = "notesCell"
    var notes:  [Notes] = []

    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ref = Database.database().reference()
        print("hit har vi kommit..")
        
            noteTableView.delegate = self
            noteTableView.dataSource = self
    }

    func noteEntry(){
        
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noteContent.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = noteTableView.dequeueReusableCell(withIdentifier: "notesCell")
        cell?.textLabel?.text = noteContent[indexPath.row]
        cell?.detailTextLabel?.text = noteNumber[indexPath.row]
        
        return cell!
        
    }
 
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}


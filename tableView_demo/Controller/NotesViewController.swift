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
    
    
    @IBOutlet weak var noteTextField: UITextField!
    let notebook = Notebook()
    @IBOutlet weak var noteTableView: UITableView!
    
    
    let noteContent = ["Första inlägget", "Suspendisse rutrum est mollis, sollicitudin nunc ac, blandit neque. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", "Tredje inlägget"]
    
    
    let notesCell = "notesCell"
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.noteTextField.isEnabled = false
        
        //        for index in 0..<noteContent.count {
        //            notebook.addEntry(entry: NoteEntry(date: Date(), contents: noteContent[index]))
        //        }
        writeToFirebase()
        retrieveMessages()
        
        ref = Database.database().reference()
        
        noteTableView.delegate = self
        noteTableView.dataSource = self
    }
    
    
    
    func writeToFirebase(){
        
        let notesDB = Database.database().reference().child("Messages")
        let note = NoteEntry(date: Date(), contents: noteTextField.text!)
        notesDB.childByAutoId().setValue(note.toAnyObject()){
            (error, reference) in
            if error != nil{
                print(error!)
            }else{
                print("note sent succesfully")
            }
        }
    }
    
    //TODO: Create the retrieveMessages method here:
    
    func retrieveMessages() {
        let notesDB = Database.database().reference().child("Messages")
        
        notesDB.observe(.childAdded, with: {
            (snapshot) in
            
            let entry = NoteEntry.init(snapshot: snapshot)
            self.notebook.addEntry(entry: entry)
            self.noteTableView.reloadData()
            
            print("ny snapshot: \(entry)")
            //let snapshotValue = snapshot.value as! Dictionary<String, String>
            //            let text = snapshotValue["contents"]!
            //            let date = snapshotValue["date"]!
            print("tar emot note från firebase")
            //            NoteEntry.init(snapshot: snapshotValue)
            
        })
    }
    
    
    @IBAction func trashButton(_ sender: Any) {
    }
    
    @IBAction func editButton(_ sender: Any) {
    }
    
    @IBAction func composeButton(_ sender: Any) {
        self.noteTextField.isEnabled = true
        let newNote = NoteEntry(date: Date(), contents: "Hej")
        notebook.addEntry(entry: newNote)
        noteTableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notebook.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = noteTableView.dequeueReusableCell(withIdentifier: "notesCell")
        _ = notebook.entry(index: indexPath.row)
        cell?.textLabel?.text = notebook.entry(index: indexPath.row)?.contents
        print(notebook.entry(index: indexPath.row)?.contents as Any)
        if let dateLabel = cell?.detailTextLabel
        {
            dateLabel.text = notebook.entry(index: indexPath.row)?.description
        }
        return cell!
    }
    
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        noteTableView.cellForRow(at: indexPath)?.textLabel?.numberOfLines = 0
        noteTableView.reloadData()
        print(indexPath)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        noteTableView.deselectRow(at:indexPath, animated: true)
        noteTableView.reloadData()
        print(indexPath)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}


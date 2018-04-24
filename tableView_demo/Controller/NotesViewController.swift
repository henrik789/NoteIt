//
//  ViewController.swift
//  Note it!
//  Created by Henrik on 2018-03-26.
//  Copyright © 2018 Henrik. All rights reserved.
//

import UIKit
import Firebase

class NotesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    let notebook = Notebook()
    @IBOutlet weak var noteTableView: UITableView!
    
    var noteMessage: String = ""
    let notesCell = "notesCell"
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        retrieveMessages()
        
        ref = Database.database().reference()
        
        noteTableView.delegate = self
        noteTableView.dataSource = self
    }
    
    
    

    
    func retrieveMessages() {
        let notesDB = Database.database().reference().child("Messages")
        
        
        notesDB.observe(.value, with: {
            (snapshot) in
            self.notebook.clear()
            
            for snap in snapshot.children {
                let entry = NoteEntry.init(snapshot: snap as! DataSnapshot)
                self.notebook.addEntry(entry: entry)
            }
            
            self.noteTableView.reloadData()
        })
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(notebook.count)
        return notebook.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = noteTableView.dequeueReusableCell(withIdentifier: "notesCell")
        _ = notebook.entry(index: indexPath.row)
        cell?.textLabel?.text = notebook.entry(index: indexPath.row)?.contents
//        print(notebook.entry(index: indexPath.row)?.contents as Any)
        if let dateLabel = cell?.detailTextLabel
        {
            dateLabel.text = notebook.entry(index: indexPath.row)?.description
        }
        noteMessage = (cell?.textLabel?.text)!
//        print(noteMessage)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        noteTableView.cellForRow(at: indexPath)?.textLabel?.numberOfLines = 0
        noteTableView.reloadData()
        
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        print("deselecting........................")
        noteTableView.deselectRow(at:indexPath, animated: true)
        noteTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView,
                   leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        let closeAction = UIContextualAction(style: .normal, title:  "Delete", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            print("OK, marked as Closed")
            
            let entry =  self.notebook.entry(index: indexPath.row)
            print("delete: \(String(describing: entry?.id))")
            self.ref.child("Messages").child((entry?.id)!).removeValue()
            self.notebook.removeEntry(row: indexPath.row)
            self.noteTableView.reloadData()
            
            success(true)
        })
        closeAction.backgroundColor = .red
        
        return UISwipeActionsConfiguration(actions: [closeAction])
        
    }
    
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        let modifyAction = UIContextualAction(style: .normal, title:  "Edit", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            print("Update action ...")
            self.performSegue(withIdentifier: "newNoteSegue", sender: self.notebook.entry(index: indexPath.row) )
            success(true)
        })
        
        modifyAction.backgroundColor = .green
        
        return UISwipeActionsConfiguration(actions: [modifyAction])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //var destinationEditController : NewNoteViewController = segue.destination as! NewNoteViewController
        //print(destinationEditController.noteEntryContents)
       //destinationEditController.noteEntryContents.text? = noteMessage
        if let s = sender as? NoteEntry? {
            let destinationEditController : NewNoteViewController = segue.destination as! NewNoteViewController
            destinationEditController.noteId = (s?.id)!
            print(destinationEditController.noteId)
        }
        
        
    }
    
//    func edit (){
//
//
//        performSegue(withIdentifier: "newNoteSegue", sender: self )
//    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}


//    func writeToFirebase(){
//
//        let notesDB = Database.database().reference().child("Messages")
//        let note = NoteEntry(date: Date(), contents: noteMessage)
//        notesDB.childByAutoId().setValue(note.toAnyObject()){
//            (error, reference) in
//            if error != nil{
//                print(error!)
//            }else{
//                print("note sent succesfully")
//            }
//        }
//    }

//TODO: Create the retrieveMessages method here:


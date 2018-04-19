//
//  newNoteController.swift
//  tableView_demo
//
//  Created by Henrik on 2018-04-19.
//  Copyright © 2018 Henrik. All rights reserved.
//

import UIKit
import Firebase

class NewNoteViewController: UIViewController {
    
    @IBOutlet weak var noteEntryContents: UITextView!
    
    var note: Notebook?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func save(_ sender: UIBarButtonItem) {
        
        let entry = NoteEntry(date: Date(), contents: noteEntryContents.text)
        note?.addEntry(entry: entry)
        
        let notesDB = Database.database().reference().child("Messages")
        notesDB.childByAutoId().setValue(entry.toAnyObject()){
            (error, reference) in
            if error != nil{
                print(error!)
            }else{
                print("note sent succesfully")
            }
        }
        
        print("knapp stängd")
        dismiss(animated: true, completion: nil)
    }

    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    
    //    @IBAction func save(_ sender: Any) {
    //
    //        let newNote = NoteEntry(date: Date(), contents: noteEntryContents.text )
    ////        Notebook.addEntry(entry: newNote)
    ////        NotesViewController.writeToFirebase()
    //        print("knapp stängd")
    //        dismiss(animated: true, completion: nil)
    //    }
    //
    //    @IBAction func cancel(_ sender: Any) {
    //        dismiss(animated: true, completion: nil)
    //    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

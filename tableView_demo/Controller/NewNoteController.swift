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
    let notebook = Notebook()
    var noteId :String?


    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let id = noteId {
            let noteRef = Database.database().reference().child("Messages").child(id)
            noteRef.observeSingleEvent(of: .value, with: { (snapshot) in
                let value = snapshot.value as! [String : String]
                let contents = value["contents"]
                
                self.noteEntryContents.text = contents
                })
            print("note edited")
        }
    }
    
    
    
    @IBAction func save(_ sender: UIBarButtonItem) {
        if noteId == nil {
            let entry = NoteEntry(date: Date(), contents: noteEntryContents.text)
            
            let notesDB = Database.database().reference().child("Messages")
            notesDB.childByAutoId().setValue(entry.toAnyObject()){
                (error, reference) in
                if error != nil{
                    print(error!)
                }else{
                    print("note sent succesfully")
                }
            }
            dismiss(animated: true, completion: nil)
        } else {
            
            let noteRef = Database.database().reference().child("Messages").child(noteId!)
            noteRef.child("contents").setValue(noteEntryContents.text)
            
            
            dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

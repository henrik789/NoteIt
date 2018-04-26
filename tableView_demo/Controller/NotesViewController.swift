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
    var cellRow: Int = 0
    var noteMessage: String = ""
    let notesCell = "notesCell"
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        retrieveMessages()
        navigationController?.navigationBar.prefersLargeTitles = true
        
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
        if let dateLabel = cell?.detailTextLabel
        {
            dateLabel.text = notebook.entry(index: indexPath.row)?.description
        }
        noteMessage = (cell?.textLabel?.text)!
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        cellRow = (noteTableView.cellForRow(at: indexPath)?.textLabel?.numberOfLines)!
        if cellRow == 0{
            noteTableView.cellForRow(at: indexPath)?.textLabel?.numberOfLines = 1
            print(cellRow)
            noteTableView.reloadData()
        }else if cellRow == 1{
            noteTableView.cellForRow(at: indexPath)?.textLabel?.numberOfLines = 0
            print(cellRow)
            noteTableView.reloadData()
        }
        
    }
    
    //    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
    //        print("deselecting................")
    //        noteTableView.cellForRow(at: indexPath)?.textLabel?.numberOfLines = 1
    //        noteTableView.reloadData()
    //    }
    
    
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
    
    
    @IBAction func logoutAction(_ sender: Any) {
            do {
                try Auth.auth().signOut()
                print("logout")
                performSegue(withIdentifier: "register", sender: self)
//                navigationController?.popToRootViewController(animated: true)
            }
            catch {
                print("error: there was a problem logging out")
            }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let s = sender as? NoteEntry? {
            let destinationEditController : NewNoteViewController = segue.destination as! NewNoteViewController
            destinationEditController.noteId = (s?.id)!
            print(destinationEditController.noteId)
        }
        
        
    }
    
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}





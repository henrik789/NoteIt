//
//  Notes.swift
//  tableView_demo
//
//  Created by Henrik on 2018-03-27.
//  Copyright © 2018 Henrik. All rights reserved.
//

import Foundation
import Firebase

class NoteEntry: CustomStringConvertible{
    
    let date: Date
    let contents: String
    let dateFormatter : DateFormatter
    let id : String
    
    var description: String {
        return dateFormatter.string(from: date)
    }
    
    init(date: Date, contents: String) {
        self.date = date
        self.contents = contents
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        id = ""
    }
    
    
    init(snapshot: DataSnapshot) {
        self.id = snapshot.key
        let snapshotValue = snapshot.value as! [String: Any]
        contents = snapshotValue["contents"]! as! String
        print(snapshotValue["date"]! as! String)
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        if let d = dateFormatter.date(from: snapshotValue["date"]! as! String) {
            date = d
        } else {
            print("Error reading date from firebase")
            date = Date()
        }
    }
    
    func dateAsString() -> String{
        
        return dateFormatter.string(from: date)
    }
    
    
    func toAnyObject() -> Any {
        return ["contents": contents,
                "date": dateAsString()]
    }
}

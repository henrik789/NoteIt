//
//  Notes.swift
//  tableView_demo
//
//  Created by Henrik on 2018-03-27.
//  Copyright © 2018 Henrik. All rights reserved.
//

import Foundation
import Firebase

class Notes{
    
    var content: String
    var completed: Bool
    var createdAt: Date
    
    init(content: String, completed: Bool = false, createdAt: Date) {
        
        self.content = content
        self.completed = completed
        self.createdAt = createdAt
        
    }
    
    func toAnyObject() -> Any {
        return ["notes": content, "completed": completed, "date": createdAt]
    }
    
}

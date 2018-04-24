//
//  Note.swift
//  tableView_demo
//
//  Created by Henrik on 2018-04-11.
//  Copyright © 2018 Henrik. All rights reserved.
//

import Foundation


class Notebook{
    
    
    private var entries = [NoteEntry]()
    
    // computed property
    var count: Int {
        return entries.count
    }
    
    func addEntry(entry: NoteEntry) {
        entries.insert(entry, at: 0)
    }
    
    func removeEntry(row : Int){
        entries.remove(at: row)
    }
    
    func entry(index: Int) -> NoteEntry? {
        if index >= 0 && index < entries.count {
            return entries[index]
        } else {
            return nil
        }
    }
    
    
}

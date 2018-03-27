//
//  ViewController.swift
//  tableView_demo
//          hej
//  Created by Henrik on 2018-03-26.
//  Copyright © 2018 Henrik. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    let protoCell = "protoCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: protoCell, for: indexPath)
        
        if let label = cell.textLabel {
            label.text = "Hej"
        }
        
        return cell
    }
    
}


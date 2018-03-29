//
//  Register.swift
//  tableView_demo
//
//  Created by Henrik on 2018-03-29.
//  Copyright © 2018 Henrik. All rights reserved.
//

import UIKit
import Firebase
import  SVProgressHUD

class RegisterViewController: UIViewController {
    
    
    //Pre-linked IBOutlets
    
   
    @IBOutlet var emailTextfield: UITextField!
    @IBOutlet var passwordTextfield: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func logInPressed(_ sender: UIButton) {
        //TODO: Log in the user
        SVProgressHUD.show()
        
        Auth.auth().signIn(withEmail: emailTextfield.text!, password: passwordTextfield.text!) { (user, error) in
            if error != nil{
                print(error!)
            }else{
                print("log in successful")
                SVProgressHUD.dismiss()
                self.performSegue(withIdentifier: "goToNotes", sender: self)
            }
        }
    }
    
    @IBAction func registerPressed(_ sender: UIButton) {
        //TODO: Set up a new user on our Firbase database
        SVProgressHUD.show()
        Auth.auth().createUser(withEmail: emailTextfield.text!, password: passwordTextfield.text!) { (user, error) in
            if error != nil{
                print (error!)
            }
            else{
                print("reg success!!")
                SVProgressHUD.dismiss()
                self.performSegue(withIdentifier: "goToNotes", sender: self)
            }
        }
        
    }
    
}

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
    
    
   
    @IBOutlet var emailTextfield: UITextField!
    @IBOutlet var passwordTextfield: UITextField!
    @IBOutlet weak var saveDefaultSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let email = UserDefaults.standard.string(forKey: "email")
        let password =  UserDefaults.standard.string(forKey: "password")

            
        print("hej!: \(email, password)")

        
        if email != "" && password != "" && email != nil  && password != nil {
        // logInPressed med email och password
            logIn(email: email!, password: password!)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func logInPressed(_ sender: UIButton) {
        //TODO: Log in the user
       logIn(email: emailTextfield.text!, password: passwordTextfield.text!)
    }
    
    @IBAction func registerPressed(_ sender: UIButton) {
        //TODO: Set up a new user on our Firbase database
        saveDefaults()
        
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

    
    func logIn(email: String, password: String ) {
    
        saveDefaults()
        
        SVProgressHUD.show()
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error != nil{
                print(error!)
            }else{
                print("log in successful")
                SVProgressHUD.dismiss()
                self.performSegue(withIdentifier: "goToNotes", sender: self)
            }
        }
        
    }
    
    
    func saveDefaults() {

        
        let email = emailTextfield.text
        let password = passwordTextfield.text
      
        if saveDefaultSwitch.isOn {
          
            print("switch is: \(saveDefaultSwitch.isOn)")
            
            UserDefaults.standard.set(email, forKey: "email")
            UserDefaults.standard.set(password, forKey: "password")
            print("hej!: \(email, password)")
            
        }else {
            
            UserDefaults.standard.removeObject(forKey: "email")
            emailTextfield.text = ""
            UserDefaults.standard.removeObject(forKey: "password")
            passwordTextfield.text = ""
            print("hej då: \(email, password)")
            
        }
        UserDefaults.standard.synchronize()
    }
    
}


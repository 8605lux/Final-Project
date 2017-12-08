//
//  loginViewController.swift
//  Best Fishing
//
//  Created by Tom on 01/10/2017.
//  Copyright © 2017 Deitel and Associates , Inc. All rights reserved.
//

import UIKit
import Firebase

class loginViewController: UIViewController {
    
    
    @IBOutlet weak var textUsername: UITextField!
    
    @IBOutlet weak var textPassword: UITextField!
    
    @IBOutlet weak var login: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func btnLogin(_ sender: Any) {
        
        if let name = textUsername.text, let password = textPassword.text
        {
            
            Auth.auth().signIn(withEmail: name, password: password) { (user, error) in
                //                // ...
                if user != nil {
                    GlobalInstance.sharedInstance.user = user
                    let vc = self.storyboard?.instantiateViewController(withIdentifier:"home")
                    self.present(vc!, animated: true, completion: nil)
                }
                else{
                    
                    let alertController = UIAlertController(title: "Login Error", message: "Error logging in, try again with valid credentials", preferredStyle: .alert)
                    
                    let okAction = UIAlertAction(title: "OK", style: .default)
                    {
                        (result: UIAlertAction) -> Void in print ("OK")
                    }
                    
                    alertController.addAction(okAction)
                    self.present(alertController, animated:true, completion: nil)
                }
            }
        }
    }
    
    
    //    @IBAction func btnlogin(_ sender: Any) {
    
    //        }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        textUsername.resignFirstResponder()
        textPassword.resignFirstResponder()
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}


//
//  RegisterViewController.swift
//  Best Fishing
//
//  Created by Tom on 01/10/2017.
//  Copyright © 2017 Deitel and Associates , Inc. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {
    
    
    @IBOutlet weak var textEmail: UITextField!
    
    @IBOutlet weak var textName: UITextField!
    
    @IBOutlet weak var textPassword: UITextField!
    
    @IBAction func Register(_ sender: Any) {
        
        if let email = textEmail.text, let password = textPassword.text{
            
            
            Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
                // ...
                
                
                if user != nil {
                    GlobalInstance.sharedInstance.user = user
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "home")
                    self.present(vc!, animated: true,completion: nil)
                }
                    
                else{
                    let alertController = UIAlertController(title: "Registration Failed", message: (error?.localizedDescription)!, preferredStyle: UIAlertControllerStyle.alert)
                    
                    
                    let okAction = UIAlertAction(title: "ok", style: UIAlertActionStyle.default) {
                        (result : UIAlertAction)-> Void in
                        print("ok")
                    }
                    
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        textEmail.resignFirstResponder()
        textPassword.resignFirstResponder()
        textName.resignFirstResponder()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
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


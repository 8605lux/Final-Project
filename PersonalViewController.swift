//
//  PersonalViewController.swift
//  Best Fishing
//
//  Created by Tom on 2017/11/15.
//  Copyright © 2017年 Deitel and Associates , Inc. All rights reserved.
//

import UIKit
import Firebase

class PersonalViewController: UIViewController {

    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var specisLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    
    let ref = Database.database().reference()
    
    var uid: String!
    var email = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref.child(self.uid)
            .observe(.value, with: { (snapshot: DataSnapshot) in
                if let item = snapshot.value  {
                    let dic = item as! [String: AnyObject]
                    
                    if let mail = dic["email"] {
                        self.email = mail as! String
                    }

                    self.emailLabel.text = self.email
                    self.emailLabel.sizeToFit()
                    
                    if let specis = dic["specis"] {
                        self.specisLabel.text = "Favorite Specis: \(specis  as! String)"
                    } else {
                        self.specisLabel.text = "Favorite Specis"
                    }
                    
                    self.specisLabel.sizeToFit()
                    
                    if let age = dic["age"] {
                        self.ageLabel.text = "Age: \(age as! String)"
                    } else {
                        self.ageLabel.text = "Age"
                    }
                    
                    self.ageLabel.sizeToFit()
                }
            })
    }

    @IBAction func buttonClicked(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "personalPostsTableViewController") as! PersonalPostsTableViewController
        
        vc.uid = uid
        vc.email = email
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

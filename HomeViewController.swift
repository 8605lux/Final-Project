//
//  HomeViewController.swift
//  Best Fishing
//
//  Created by Tom on 2017/10/18.
//  Copyright © 2017年 Deitel and Associates , Inc. All rights reserved.
//

import UIKit

import Firebase

class HomeViewController: UITabBarController {
    
    @IBOutlet weak var bottomTabBar: UITabBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for item in bottomTabBar.items! {
            let unselectedItem: NSDictionary = [NSForegroundColorAttributeName: UIColor.gray, NSFontAttributeName: UIFont.systemFont(ofSize: 18)]
            let selectedItem: NSDictionary = [NSForegroundColorAttributeName: UIColor.darkGray, NSFontAttributeName: UIFont.systemFont(ofSize: 18)]
            item.setTitleTextAttributes(unselectedItem as? [String : AnyObject], for: .normal)
            item.setTitleTextAttributes(selectedItem as? [String : AnyObject], for: .selected)
        }
        
        let ref = Database.database().reference()
        
        ref.observe(DataEventType.value, with: { (snapshot) in
            print("observe")
        })
        
        ref.child("post").setValue("test") { (error, ref) in
            print("complete")
        }
    }
}

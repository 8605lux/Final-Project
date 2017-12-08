//
//  PersonalPostsTableViewController.swift
//  Best Fishing
//
//  Created by Tom on 2017/11/15.
//  Copyright © 2017年 Deitel and Associates , Inc. All rights reserved.
//

import UIKit
import Firebase

class PersonalPostsTableViewController: UITableViewController {

    let ref = Database.database().reference()
    var dataArray = [[String: Any]]()
    var uid: String!
    var email: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = email
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        ref.child("posts")
            .queryOrdered(byChild: "uid").queryEqual(toValue: uid)
            .observe(.value, with: { (snapshot: DataSnapshot) in
                self.dataArray.removeAll()
                for item in snapshot.children {
                    let ele: DataSnapshot = item as! DataSnapshot
                    let snapshotValue = ele.value as! [String: AnyObject]
                    self.dataArray.append(snapshotValue)
                }
                self.tableView.reloadData()
            })
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! PostTableViewCell
        
        // Configure the cell...
        let item = dataArray[indexPath.row]
        
        cell.setImage(image:item["image"] as! String , title: item["text"] as! String)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

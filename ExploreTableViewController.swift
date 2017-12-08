//
//  ExploreTableViewController.swift
//  Best Fishing
//
//  Created by Tom on 2017/11/15.
//  Copyright © 2017年 Deitel and Associates , Inc. All rights reserved.
//

import UIKit
import Firebase

class ExploreTableViewController: UITableViewController {

    let ref = Database.database().reference()
    var dataArray = [[String: Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        ref.child("posts")
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "exploreCell", for: indexPath) as! ExploreTableViewCell
        
        let item = dataArray[indexPath.row]
        
        cell.setImage(image:item["image"] as! String, title: item["text"] as! String, email: item["email"] as! String)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        let item = dataArray[indexPath.row]
        let uid = item["uid"] as! String
        
        if uid == GlobalInstance.sharedInstance.user.uid {
            return
        }
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "personalViewController") as! PersonalViewController
        vc.uid = uid
        self.navigationController?.pushViewController(vc, animated: true)
    }

}

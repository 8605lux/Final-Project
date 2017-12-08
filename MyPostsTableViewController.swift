//
//  MyPostsTableViewController.swift
//  Best Fishing
//
//  Created by Tom on 2017/11/8.
//  Copyright © 2017年 Deitel and Associates , Inc. All rights reserved.
//

import UIKit
import Firebase

class MyPostsTableViewController: UITableViewController {

    let ref = Database.database().reference()
    var dataArray = [[String: Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        //        self.tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "postCell")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        ref.child("posts")
            .queryOrdered(byChild: "uid").queryEqual(toValue: GlobalInstance.sharedInstance.user.uid)
            .observe(.value, with: { (snapshot: DataSnapshot) in
                self.dataArray.removeAll()
                for item in snapshot.children {
                    let ele: DataSnapshot = item as! DataSnapshot
                    let snapshotValue = ele.value as! [String: AnyObject]
                    self.dataArray.append(snapshotValue)
                }
                print("query complete")
                self.tableView.reloadData()
            })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
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

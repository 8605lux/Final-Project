//
//  MyPostsViewController.swift
//  Best Fishing
//
//  Created by Tom on 2017/10/18.
//  Copyright © 2017年 Deitel and Associates , Inc. All rights reserved.
//

import UIKit
import Firebase

class MyProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, EditProtocal {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var editProfileButton: UIButton!
    @IBOutlet weak var spicsLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    
    let ref = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        avatarImageView.layer.masksToBounds = true
        avatarImageView.backgroundColor = UIColor.white
        avatarImageView.layer.borderColor = UIColor.gray.cgColor
        avatarImageView.layer.borderWidth = 1
        avatarImageView.layer.cornerRadius = avatarImageView.frame.size.height / 2
        
        editProfileButton.layer.borderWidth = 1
        editProfileButton.layer.cornerRadius = 5
        editProfileButton.layer.borderColor = UIColor.lightGray.cgColor
        
        ref.child(GlobalInstance.sharedInstance.user.uid)
            .observe(.value, with: { (snapshot: DataSnapshot) in
                if let item = snapshot.value  {
                    let dic = item as? [String: AnyObject]
                    if dic != nil {
                        if let specis = dic!["specis"] {
                            self.spicsLabel.text = "Favorite Specis: \(specis as! String)"
                        } else {
                            self.spicsLabel.text = "Favorite Specis"
                        }
                        
                        if let age = dic!["age"] {
                            self.ageLabel.text = "Age: \(age)"
                        } else {
                            self.ageLabel.text = "Age"
                        }
                    } else {
                        self.spicsLabel.text = "Favorite Specis"
                        self.ageLabel.text = "Age"
                    }
                    self.spicsLabel.sizeToFit()
                    self.ageLabel.sizeToFit()
                }
            })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cameraClicked(_ sender: Any) {
        let controller = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
            
        })
        
        let pickAction = UIAlertAction(title: "Pick a Photo", style: .default, handler: { action in
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                let imgPicker = UIImagePickerController()
                imgPicker.delegate = self
                imgPicker.sourceType = .photoLibrary
                imgPicker.allowsEditing = true
                self.present(imgPicker, animated: true, completion: {
                    
                })
            }
        })
        
        let takeAction = UIAlertAction(title: "Take a Photo", style: .default, handler: { action in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                let imgPicker = UIImagePickerController()
                imgPicker.delegate = self
                imgPicker.sourceType = .camera
                imgPicker.allowsEditing = false
                self.present(imgPicker, animated: true, completion: {
                    
                })
            }
        })
        
        controller.addAction(pickAction)
        controller.addAction(takeAction)
        controller.addAction(cancelAction)
        self.present(controller, animated: true, completion: {
            
        })
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            avatarImageView.image = selectedImage
        }
        picker.dismiss(animated: true, completion: { _ in })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editProfile" {
            let controller = segue.destination as! UINavigationController
            let editController = controller.viewControllers.first as! EditProfileViewController
            editController.delegate = self
        }
    }
    
    func save(specis: String?, age: String?) {
        var post = [String: Any]()
        post["age"] = age ?? ""
        post["specis"] = specis ?? ""
        post["email"] = GlobalInstance.sharedInstance.user.email!
        
        ref.child(GlobalInstance.sharedInstance.user.uid).setValue(post) { (error, ref) in
            if error != nil {
                print("error: \(error!.localizedDescription)")
            }
        }
    }
    
    @IBAction func signOut(_ sender: Any) {
        
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            dismiss(animated: true, completion: nil)
        } catch let signOutError as NSError {
            print ("Error signing out: \(signOutError.localizedDescription)")
        }
    }
}

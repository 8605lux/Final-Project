//
//  WriteViewController.swift
//  Best Fishing
//
//  Created by Tom on 2017/11/8.
//  Copyright © 2017年 Deitel and Associates , Inc. All rights reserved.
//

import UIKit
import Firebase

class WriteViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        textView.layer.borderColor = UIColor.gray.cgColor
        textView.layer.borderWidth = 1
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        self.indicator.hidesWhenStopped = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func photoClicked(_ sender: Any) {
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
    
    @IBAction func submitClicked(_ sender: Any) {
        let storageRef = Storage.storage().reference()
        
        if imageView.image == nil {
            return
        }
        
        if self.textView.text == "" {
            return
        }
        
        
        self.indicator.isHidden = false
        self.indicator.startAnimating()
        // Data in memory
        let data = UIImageJPEGRepresentation(imageView.image!, 1.0)!
        
        // Create a reference to the file you want to upload
        let imageRef = storageRef.child("images/\(Date().timeIntervalSince1970).jpg")
        
        
        // Create file metadata including the content type
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        // Upload the file to the path "images/rivers.jpg"
        imageRef.putData(data, metadata: metadata) { (metadata, error) in
            guard let metadata = metadata else {
                // Uh-oh, an error occurred!
                self.indicator.stopAnimating()
                return
            }
            // Metadata contains file metadata such as size, content-type, and download URL.
            let downloadURL = metadata.downloadURL()
            
            let ref = Database.database().reference()
            
            var post = [String: Any]()
            post["text"] = self.textView.text
            post["uid"] = GlobalInstance.sharedInstance.user.uid
            post["email"] = GlobalInstance.sharedInstance.user.email
            post["image"] = downloadURL?.absoluteString
            
            ref.child("posts").childByAutoId().setValue(post) { (error, ref) in
                print("submit complete")
                self.indicator.stopAnimating()
                if error != nil {
                    print("error: \(error!.localizedDescription)")
                } else {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.image = selectedImage
        }
        picker.dismiss(animated: true, completion: { _ in })
    }
}

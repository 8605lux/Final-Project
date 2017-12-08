//
//  EditProfileViewController.swift
//  Best Fishing
//
//  Created by Tom on 2017/10/18.
//  Copyright © 2017年 Deitel and Associates , Inc. All rights reserved.
//

import UIKit

protocol EditProtocal {
    func save(specis: String?, age: String?)
}

class EditProfileViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var ageTextField: UITextField!
    
    
    var delegate: EditProtocal?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func save(_ sender: Any) {
        if let d = delegate {
            d.save(specis: textField.text, age: ageTextField.text)
        }
        self.dismiss(animated: true, completion: nil)
    }
}


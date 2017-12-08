//
//  ExploreTableViewCell.swift
//  Best Fishing
//
//  Created by Tom on 2017/11/15.
//  Copyright © 2017年 Deitel and Associates , Inc. All rights reserved.
//

import UIKit

class ExploreTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var email: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setImage(image: String, title: String, email: String) {
        
        self.imgView.kf.setImage(with: URL(string: image))
        self.imgView.layer.masksToBounds = true
        self.imgView.contentMode = .scaleAspectFill
        self.titleLabel.text = title
        self.email.text = email
    }
}

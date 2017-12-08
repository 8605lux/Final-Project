//
//  PostTableViewCell.swift
//  Best Fishing
//
//  Created by Tom on 2017/11/7.
//  Copyright © 2017年 Deitel and Associates , Inc. All rights reserved.
//

import UIKit
import Kingfisher

class PostTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var title: UILabel!
    
    func setImage(image: String, title: String) {
        
        self.imgView.kf.setImage(with: URL(string: image))
        self.imgView.layer.masksToBounds = true
        self.imgView.contentMode = .scaleAspectFill
        self.title.text = title
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}

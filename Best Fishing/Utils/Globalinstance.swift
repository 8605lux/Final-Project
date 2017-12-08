//
//  Global.swift
//  TalksBeauty
//
//  Created by Tom on 2017/11/6.
//  Copyright © 2017年 Deitel and Associates. All rights reserved.
//

import Foundation
import Firebase

class GlobalInstance {
    static let sharedInstance = GlobalInstance()
    
    private init() {
        
    }
    
    var user: User!
}

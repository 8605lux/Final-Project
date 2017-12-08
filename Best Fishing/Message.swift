//
//  Message.swift
//  geoMessenger
//
//  Created by Ivor D. Addo on 2/26/17.
//  Copyright © 2017 deHao. All rights reserved.
//

import UIKit
import MapKit

class Message: NSObject, MKAnnotation {

    var title: String?
    var locationName: String?
    var coordinate = CLLocationCoordinate2D()
    
    init(title: String, locationName: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.locationName = locationName
        self.coordinate = coordinate
        
        super.init()
    }
    
    override init() {
        super.init()
    }
    
    var subtitle: String? {
        return locationName
    }
    
}

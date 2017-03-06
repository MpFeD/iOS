//
//  UneAnnotation.swift
//  David_Toty_TP7_iSouvenir
//
//  Created by m2sar on 24/11/2016.
//  Copyright © 2016 UPMC. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class UneAnnotation : NSObject, MKAnnotation{
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(c:CLLocationCoordinate2D){
        coordinate = c
        super.init()
    }
    
    convenience init (c:CLLocationCoordinate2D, t:String){
        self.init(c:c)
        title=t
    }
    
    convenience init(c:CLLocationCoordinate2D, t:String, st:String){
        self.init(c:c,t:t)
        subtitle = st
    }
    
    func setSubTitle(s:String){
        subtitle=s
    }
}

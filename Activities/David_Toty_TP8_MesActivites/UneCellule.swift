//
//  UneCellule.swift
//  David_Toty_TP8_MesActivites
//
//  Created by Knu on 30/11/16.
//  Copyright © 2016 Knu. All rights reserved.
//

import Foundation
import UIKit

class UneCellule : NSObject {
    
    var priorite = 0
    var but = ""
    
    init(p: Int, b: String){
        priorite = p
        but = b
    }
}

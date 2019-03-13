//
//  Adopt.swift
//  Pet Shop
//
//  Created by Michel Bou khalil on 2/18/19.
//  Copyright © 2019 Michel Bou khalil. All rights reserved.
//

import Foundation

enum cellsTypes: String {
    
    case label = "label"
    case checkButtons = "checkButtons"
    case switchControl = "switchControl"
    case textField = "textField"
    case mapView = "mapView"
    
}

struct formRow {
    
    var title : String
    var type : cellsTypes.RawValue
    var value : String
    
}

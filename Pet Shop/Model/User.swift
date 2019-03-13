//
//  User.swift
//  Pet Shop
//
//  Created by Michel Bou khalil on 2/13/19.
//  Copyright © 2019 Michel Bou khalil. All rights reserved.
//

import Foundation

class  User{
    
    static let userInfo = User()
    
    var email:String?
    var fullName:String?
    var sexe: Bool?
    var phone: Int?
    var age : Int?
    var income : String?
    var extraIncome : Bool?
    var maritalStatus: String?
    var id : String?
    var favorites : AllPets?
    
    init() {}

}

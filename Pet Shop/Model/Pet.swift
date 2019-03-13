//
//  Pets.swift
//  Pet Shop
//
//  Created by Michel Bou khalil on 2/12/19.
//  Copyright © 2019 Michel Bou khalil. All rights reserved.
//

import Foundation

struct Start : Codable {
    var results : [Pet]?
}

struct Pet : Codable {
    
    var objectId : String?
    var updatedAt : String?
    var createdAt : String?
    var name: String?
    var type:String?
    var extras : extras_codable?
    
}

struct extras_codable : Codable {
    var imageURL:String?
    var age:Int?
    var description : String?
    
    private enum CodingKeys: String, CodingKey {
        case age, description
        case imageURL = "image_url"
    }
}

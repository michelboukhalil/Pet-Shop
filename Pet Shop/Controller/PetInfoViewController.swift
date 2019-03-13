//
//  PetInfoViewController.swift
//  Pet Shop
//
//  Created by Michel Bou khalil on 2/15/19.
//  Copyright © 2019 Michel Bou khalil. All rights reserved.
//

import UIKit
import Kingfisher

class PetInfoViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var petImage: UIImageView!
    @IBOutlet weak var petName: UILabel!
    @IBOutlet weak var petAge: UILabel!
    @IBOutlet weak var petDescription: UILabel!
    @IBOutlet weak var adoptButton: UIButton!
    
    var name:String?
    var age:Int?
    var descriptions : String?
    var image : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        petName.text = name
        petDescription.text = descriptions
        petAge.text = age?.description
        petImage.kf.setImage(with: URL(string: image ?? ""))
    
    }

}

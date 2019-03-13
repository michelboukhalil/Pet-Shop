//
//  ListView.swift
//  Pet Shop
//
//  Created by Michel Bou khalil on 2/18/19.
//  Copyright © 2019 Michel Bou khalil. All rights reserved.
//

import UIKit
import CoreData
import Alamofire

class ListView: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {
    
     var petArray : [AllPets]?
    
    
    let id = UserDefaults.standard.value(forKey: "id")
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    @IBOutlet weak var listTableView: UITableView!
   


    override func viewDidLoad() {
        
        super.viewDidLoad()

        listTableView.dataSource = self
        listTableView.delegate = self
        try? fetchedResultsControllerCats.performFetch()
        petArray = fetchedResultsControllerCats.fetchedObjects
        
        self.listTableView.reloadData()
        
    }
    
    
    @IBAction func favButton(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.1, delay: 0.1, options: .curveLinear, animations: {
            sender.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            
            
        }) { (success) in
            UIView.animate(withDuration: 0.1, delay: 0.1, options: .curveLinear, animations: {
                sender.isSelected = !sender.isSelected
                sender.transform = .identity
            }, completion: nil)
        }
        let row = sender.tag
        
    
        
        guard let clickeditem = self.petArray?[row] else { return }
        
        if clickeditem.userID == nil || clickeditem.userID != id as! String{
            if clickeditem.fav == true {
                clickeditem.fav = false
            }
     
        }
        
        clickeditem.fav = !clickeditem.fav
    
        if clickeditem.fav == true {
            clickeditem.userID = UserDefaults.standard.string(forKey: "id")
        }
        else {
            clickeditem.userID = ""
//            user?.favoritePet.re
//                context.delete(clickeditem)

        
        }
        
        try? self.context.save()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petArray?.count ?? 0
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! cellFormat
        
        
        if let pet = petArray?[indexPath.row] {
            
            cell.petAge.text = pet.extras?.age
            cell.petName.text = pet.name
            cell.petImage.kf.setImage(with: URL(string: (pet.extras?.imageURL)!))
            cell.favorite.tag = indexPath.row

            
            if (pet.userID == self.id as? String) &&  pet.fav  {
                //show check
                cell.favorite.setImage(UIImage(named: "Checkmark"), for: .normal)
            }
            else {
                //show unchek
                cell.favorite.setImage(UIImage(named: "Checkmarkempty"), for: .normal)
            }
        }
        
        return cell
        
    }
    
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
                performSegue(withIdentifier: "goToPetInfo", sender: self)

            }
    
            override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                let destinationVC = segue.destination as! PetInfoViewController
                if let indexPath = listTableView.indexPathForSelectedRow{

                    destinationVC.age =  Int((petArray?[indexPath.row].extras?.age)!)
                    destinationVC.name = petArray?[indexPath.row].name
                    destinationVC.descriptions = petArray?[indexPath.row].extras?.desc
                    destinationVC.image = petArray?[indexPath.row].extras?.imageURL
        
                }
            }
    
    
    fileprivate lazy var fetchedResultsControllerCats: NSFetchedResultsController<AllPets> = {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        // Create Fetch Request
        let fetchRequest: NSFetchRequest<AllPets> = AllPets.fetchRequest()

        // Configure Fetch Request
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "updateDate", ascending: false)]
        fetchRequest.predicate = NSPredicate(format: "type == %@", "const_cat")
        
        // Create Fetched Results Controller
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        // Configure Fetched Results Controller
        fetchedResultsController.delegate = self
        
        return fetchedResultsController
    }()
}



class cellFormat : UITableViewCell {
    
    @IBOutlet weak var petImage: UIImageView!
    @IBOutlet weak var favorite: UIButton!
    
    @IBOutlet weak var petName: UILabel!
    
    @IBOutlet weak var petAge: UILabel!
}

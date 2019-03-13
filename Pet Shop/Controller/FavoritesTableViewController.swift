//
//  FavoritesTableViewController.swift
//  Pet Shop
//
//  Created by Michel Bou khalil on 2/21/19.
//  Copyright © 2019 Michel Bou khalil. All rights reserved.
//

import UIKit
import CoreData

class FavoritesTableViewController: UITableViewController , NSFetchedResultsControllerDelegate {
    
    let userId = UserDefaults.standard.string(forKey: "id")
    var favPets : [AllPets]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.favPets = AllPets.getUserFavPets(userId: userId ?? "")!
        tableView.reloadData()
    }
    
    

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favPets?.count ?? 0

    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! cellFormat
        
        
        if let pet = favPets?[indexPath.row] {
            
            cell.petAge.text = pet.extras?.age
            cell.petName.text = pet.name
            cell.petImage.kf.setImage(with: URL(string: (pet.extras?.imageURL)!))
            
        }
        
        return cell
        
    }
    
//    fileprivate lazy var fetchedResultsController: NSFetchedResultsController<CurrentUser> = {
//
//        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//        // Create Fetch Request
//        let fetchRequest: NSFetchRequest<CurrentUser> = CurrentUser.fetchRequest()
//
//        // Configure Fetch Request
////        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "updateDate", ascending: false)]
////        fetchRequest.predicate = NSPredicate(format: "fav == %@", "1")
//
//        // Create Fetched Results Controller
//        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
//
//        // Configure Fetched Results Controller
//        fetchedResultsController.delegate = self
//
//        return fetchedResultsController
//    }()
}

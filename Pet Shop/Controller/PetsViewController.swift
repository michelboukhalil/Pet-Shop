import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher
import CoreData
import FacebookLogin
import FacebookCore
import FBSDKLoginKit

class PetsViewController: UIViewController ,NSFetchedResultsControllerDelegate {
    
    @IBOutlet weak var gridContainer: UIView!
    var listView: ListView!
    var gridView: GridView!
    
    let id = UserDefaults.standard.value(forKey: "id")
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    @IBOutlet weak var listContainer: UIView!
    
    @IBOutlet weak var listGridSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var loading: UIActivityIndicatorView!
    var petArray = [Pet]()

    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    let baseUrl = "https://eurisko-push.herokuapp.com/parse/classes/pets"
    let appID = "HsYqu0zBI93H0mmDLkyHYb4TvJWSwtqQt59TiJ4v"
    
    var finalUrl = ""

    override func viewDidLoad() {
        super.viewDidLoad()
            getPets()
        
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
            }
    
    @IBAction func petChanged(_ sender: Any) {
        
        switch segmentedControl.selectedSegmentIndex
        {
        case 0: try? fetchedResultsControllerCats.performFetch()
                listView.petArray = fetchedResultsControllerCats.fetchedObjects
                listView.listTableView.reloadData()
                gridView.petArray = fetchedResultsControllerCats.fetchedObjects
                gridView.gridView.reloadData()
        
//                 getPets()

        case 1:  try? fetchedResultsControllerDogs.performFetch()
            listView.petArray = fetchedResultsControllerDogs.fetchedObjects
            listView.listTableView.reloadData()
            gridView.petArray = fetchedResultsControllerDogs.fetchedObjects
            gridView.gridView.reloadData()
//            getPets()

            
        default:
            break
        }
    }

    @IBAction func logOutButton(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: "status")
        Switcher.updateRootVC()
        
        let fbLoginManager = FBSDKLoginManager()
        fbLoginManager.logOut()
        
        

    }
    
    func getPets (){
        
        //show
        loading.startAnimating()
        Alamofire.request(baseUrl,
                          headers: ["X-Parse-Application-Id": self.appID])
            
            .responseJSON { response in
                guard response.result.isSuccess else {
                    print("Error while fetching tags: \(String(describing: response.result.error))")
                    return
                }
                
                guard let data = response.data, let result = try? JSONDecoder().decode(Start.self, from: data) else { return }
                
                self.petArray = result.results!
                
                AllPets.createorFetch(models: self.petArray)!
                
                try? self.fetchedResultsControllerCats.performFetch()
                try? self.fetchedResultsControllerDogs.performFetch()
                self.listView.listTableView.reloadData()
                self.gridView.gridView.reloadData()
                self.loading.stopAnimating()
                
              
            
        }
        
       
    
    }

    @IBAction func viewsChanged(_ sender: UISegmentedControl) {
 
        switch listGridSegmentedControl.selectedSegmentIndex {
        case 0:
            listContainer.alpha = 1
            gridContainer.alpha = 0
        case 1:
            listContainer.alpha = 0
            gridContainer.alpha = 1
        default:
            listContainer.alpha = 1
            gridContainer.alpha = 0
        }

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "listView" {
            listView = segue.destination as? ListView ?? ListView()
        } else if segue.identifier == "gridView" {
            gridView = segue.destination as? GridView ?? GridView()
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
    
    fileprivate lazy var fetchedResultsControllerDogs: NSFetchedResultsController<AllPets> = {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        // Create Fetch Request
        let fetchRequest: NSFetchRequest<AllPets> = AllPets.fetchRequest()
        
        // Configure Fetch Request
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "updateDate", ascending: false)]
        fetchRequest.predicate = NSPredicate(format: "type == %@", "const_dog")
        
        // Create Fetched Results Controller
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        // Configure Fetched Results Controller
        fetchedResultsController.delegate = self
        
        return fetchedResultsController
    }()
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        listView.listTableView.beginUpdates()

    }

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        listView.listTableView.endUpdates()

        listView.listTableView.reloadData()
    }
    
        func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
    
            if type == .update {
                if controller == fetchedResultsControllerDogs {
    
                    listView.petArray = fetchedResultsControllerDogs.fetchedObjects
                    listView.listTableView.reloadData()
                    gridView.petArray = fetchedResultsControllerDogs.fetchedObjects
                    gridView.collectionCell.reloadData()
    
    
                } else if controller == fetchedResultsControllerCats {
                    listView.petArray = fetchedResultsControllerCats.fetchedObjects
                    listView.listTableView.reloadData()
                    gridView.petArray = fetchedResultsControllerCats.fetchedObjects
                    gridView.collectionCell.reloadData()
    
                }
            }
    
    
        }



}






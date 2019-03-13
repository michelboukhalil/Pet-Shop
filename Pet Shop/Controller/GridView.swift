import UIKit
import CoreData

class GridView: UIViewController , UICollectionViewDataSource,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, NSFetchedResultsControllerDelegate {
    
    var petArray : [AllPets]?
    var parentView : PetsViewController!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var gridView: UICollectionView!
    @IBOutlet weak var collectionCell: UICollectionView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
//        parentView!.getPets()
        gridView.dataSource = self
        gridView.delegate = self
        
        try? fetchedResultsControllerCats.performFetch()
        petArray = fetchedResultsControllerCats.fetchedObjects
        
        self.gridView.reloadData()
        
        

    }
    
    @IBAction func gridFav(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.1, delay: 0.1, options: .curveLinear, animations: {
            sender.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            
            
        }) { (success) in
            UIView.animate(withDuration: 0.1, delay: 0.1, options: .curveLinear, animations: {
                sender.isSelected = !sender.isSelected
                sender.transform = .identity
            }, completion: nil)
        }
        
        let row = sender.tag
        let clickeditem = self.petArray?[row]
        let isFav = clickeditem?.fav ?? false
        petArray?[row].fav = !isFav
        try? self.context.save()
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return petArray?.count ?? 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! collectionCell
        
        
        if let pet = petArray?[indexPath.row] {
            
            cell.ageLabel.text = pet.extras?.age!
            cell.nameLabel.text = pet.name!
            cell.imageView.kf.setImage(with: URL(string: (pet.extras?.imageURL)!))
            gridView.allowsSelection = true
            
            cell.favorite.tag = indexPath.row
            
            if pet.fav {
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

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

   
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let destinationVC = storyboard.instantiateViewController(withIdentifier: "PetInfoViewController") as! PetInfoViewController

        destinationVC.age = Int((petArray?[indexPath.row].extras?.age)!)
        destinationVC.name = petArray?[indexPath.row].name
        destinationVC.descriptions = petArray?[indexPath.row].extras?.desc
        destinationVC.image = petArray?[indexPath.row].extras?.imageURL
        
        navigationController?.pushViewController(destinationVC, animated: false)
        
        
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = self.view.frame.size.width / 3
        let height = self.view.frame.size.height / 5
        
        
        return CGSize(width: width , height: height)
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
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


class collectionCell : UICollectionViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var favorite: UIButton!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var ageLabel: UILabel!
}




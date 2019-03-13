import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var mapSearch: UITextField!
    var matchingItems: [MKMapItem] = [MKMapItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    

    @IBAction func searchLocation(_ sender: UITextField) {
        
        _ = sender.resignFirstResponder()
        map.removeAnnotations(map.annotations)
        self.performSearch()
    }
    
    func performSearch() {
        
        matchingItems.removeAll()
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = mapSearch.text
        request.region = map.region
        
        let search = MKLocalSearch(request: request)
        
        search.start(completionHandler: {(response, error) in
            
            if let results = response {
                
                if let err = error {
                    print("Error occurred in search: \(err.localizedDescription)")
                } else if results.mapItems.count == 0 {
                    print("No matches found")
                } else {
                    print("Matches found")
                    
                    for item in results.mapItems {
                        print("Name = \(item.name ?? "No match")")
                        print("Phone = \(item.phoneNumber ?? "No Match")")
                        print(item.placemark.coordinate.latitude)
                        print(item.placemark.coordinate.longitude)
                        
                        self.matchingItems.append(item as MKMapItem)
                        print("Matching items = \(self.matchingItems.count)")
                        
                        let annotation = MKPointAnnotation()
                        annotation.coordinate = item.placemark.coordinate
                        annotation.title = item.name
                        self.map.addAnnotation(annotation)
                    }
                }
            }
        })
    }
    
}

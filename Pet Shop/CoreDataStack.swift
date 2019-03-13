//
//  CoreDataStack.swift
//  Pet Shop
//
//  Created by Michel Bou khalil on 2/20/19.
//  Copyright © 2019 Michel Bou khalil. All rights reserved.
//

import Foundation
import CoreData
import UIKit
extension AllPets {
    
    class func getUserFavPets(userId:String) -> [AllPets]? {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequset: NSFetchRequest<AllPets> = AllPets.fetchRequest()
        fetchRequset.sortDescriptors = [NSSortDescriptor.init(key: "updateDate", ascending: false)]
        fetchRequset.predicate = NSPredicate.init(format: "userID == %@ && fav == true", userId)
        let results = try? context.fetch(fetchRequset)
        
        return results ?? [AllPets]()
    }
    
    class func createOrFetch(model:Pet) -> AllPets? {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequset: NSFetchRequest<AllPets> = AllPets.fetchRequest()
        fetchRequset.sortDescriptors = [NSSortDescriptor.init(key: "updateDate", ascending: false)]
        
        fetchRequset.predicate = NSPredicate.init(format: "id == %@", model.objectId ?? "")
        
        var item:AllPets?
        
        if let fetchedItem = try? context.fetch(fetchRequset).first, fetchedItem != nil {
            item = fetchedItem
        }
        else {
            item = AllPets(context: context)
        }
        
        item?.name = model.name ?? ""
        item?.type = model.type ?? ""
        item?.id = model.objectId ?? ""
        item?.updateDate = model.updatedAt ?? ""
        item?.extras = createOrFetchExtras(model: model)
        //item?.userID = UserDefaults.standard.string(forKey: "id")
        
        
        try? context.save()
        return item
    }
    
    class func createorFetch(models:[Pet]) -> [AllPets]? {
        
        var array = [AllPets]()
        if models.count > 0 {
            for model in models {
                let object = AllPets.createOrFetch(model: model)
                array.append(object ?? AllPets())
            }
        }
        
        return array
    }
    
    
    class func createOrFetchExtras(model:Pet) -> Extras {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequset: NSFetchRequest<Extras> = Extras.fetchRequest()
        fetchRequset.sortDescriptors = [NSSortDescriptor.init(key: "parentID", ascending: false)]
        fetchRequset.predicate = NSPredicate.init(format: "parentID == %@", model.objectId ?? "")
        
        var item:Extras?
        
        if let fetchedItem = try? context.fetch(fetchRequset).first , fetchedItem != nil {
            item = fetchedItem
        } else {
            item = Extras(context: context)
        }
        
        item?.age = model.extras?.age?.description
        item?.desc = model.extras?.description
        item?.imageURL = model.extras?.imageURL
        item?.parentID = model.objectId
        
        
        try? context.save()
        
        return item!
        
    }

    
    
    
}


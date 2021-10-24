//
//  CoreDataManager.swift
//  Do me
//
//  Created by Yavuz Selim Bitmez on 15.10.2021.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager{
    static let shared = CoreDataManager()
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
   
    func updateData(data:TaskModel){
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "DomeDB")
        fetchRequest.predicate = NSPredicate(format: "id = %@", "\(data.id)")
        do {
            let fetchResults = try managedContext.fetch(fetchRequest) as! [NSManagedObject]
            fetchResults.first?.setValue(data.header, forKey: "header")
            fetchResults.first?.setValue(data.content, forKey: "content")
            fetchResults.first?.setValue(data.date, forKey: "date")
            
            NSLog("[CoreDataManager] Updated")
        } catch let error {
            NSLog("[CoreDataManager] Update Error %@", error.localizedDescription)
        }
        //TODO: Update
    }
    
    func removeData(data:DetailPresentation){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "DomeDB")
        request.predicate = NSPredicate(format: "id = %@", "\(data.id)")
        if let fetchResults = try? managedContext.fetch(request) as? [NSManagedObject] {
            for i in fetchResults {
                managedContext.delete(i)
            }
        }
        do {
            try managedContext.save()
            NSLog("[CoreDataManager] Deleted")
        } catch let error {
            NSLog("[CoreDataManager] Delete Error %@", error.localizedDescription)

        }
        //TODO: Remove
    }

    func fetchData(completion:@escaping ([TaskModel]?,Error?)->Void){
        var tasks = [TaskModel]()
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "DomeDB")
        do {
            let fetchResults = try managedContext.fetch(fetchRequest) as! [NSManagedObject]
            for result in fetchResults {
                tasks.append(TaskModel(header: result.value(forKey: "header") as! String,
                                       date: result.value(forKey: "date") as? Date ?? Date(),
                                       content: result.value(forKey: "content") as? String ?? "Content",
                                       id: result.value(forKey: "id") as? String ?? "",
                                       repeats: result.value(forKey: "repeats") as? Bool ?? false)
            )}
            NSLog("[CoreDataManager] Fetched data")
            completion(tasks,nil)
        } catch let error {
            NSLog("[CoreDataManager] Fetch Error %@", error.localizedDescription)
            completion(nil,error)
        }
    }
    func saveData(data:TaskModel){
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "DomeDB", in: managedContext)!
        let item = NSManagedObject(entity: entity, insertInto: managedContext)
        item.setValue(data.header, forKey: "header")
        item.setValue(data.content, forKey: "content")
        item.setValue(data.date, forKey: "date")
        item.setValue(item.objectID.uriRepresentation().absoluteString, forKey: "id")

        do {
            try managedContext.save()
            NSLog("[CoreDataManager] Saved")
        } catch let error {
            NSLog("[CoreDataManager] Save Error %@", error.localizedDescription)
        }
    }
    
    deinit {
        NSLog("[CoreDataManager] Deinit")
    }
}


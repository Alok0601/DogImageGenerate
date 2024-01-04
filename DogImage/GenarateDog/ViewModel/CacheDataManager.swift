//
//  CacheDataManager.swift
//  DogImage
//
//  Created by Alok Ranjan on 04/01/24.
//

import Foundation
import UIKit
import CoreData

protocol CacheDataProtocol: AnyObject {
    func addImage(_ image: DogImage)
    func getImages() -> [DogImage]
    func clearCache()
}


class CacheDataManager: CacheDataProtocol {
    private var images: [DogImage] = []
    
    func addImage(_ image: DogImage) {
        images.insert(image, at: 0)
        if images.count > 20 {
            images.removeLast()
        }
        DispatchQueue.main.async {
            self.saveImages()
        }
    }
    
    func getImages() -> [DogImage] {
        return fetchImagesFromCoreData()
    }
    
    func clearCache() {
        images.removeAll()
        deleteAllData()
    }
    
    
    private func saveImages() {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        // Save new images
        for image in images {
            let entity = NSEntityDescription.entity(forEntityName: "DogImageEntity", in: managedContext)!
            let dogImageEntity = NSManagedObject(entity: entity, insertInto: managedContext)
            dogImageEntity.setValue(image.message, forKey: "message")
            dogImageEntity.setValue(image.status, forKey: "status")
        }
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    private func fetchImagesFromCoreData() -> [DogImage] {
        var fetchedImages: [DogImage] = []
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return fetchedImages
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "DogImageEntity")
        
        do {
            let results = try managedContext.fetch(fetchRequest)
            
            for data in results as! [NSManagedObject] {
                // Assuming DogImageEntity has attributes like "message" and "status"
                if let message = data.value(forKey: "message") as? String,
                   let status = data.value(forKey: "status") as? String {
                    let dogImage = DogImage(message: message, status: status)
                    fetchedImages.append(dogImage)
                }
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        return fetchedImages
    }
    
    func deleteAllData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "DogImageEntity")
        
        // Create a batch delete request
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            // Execute the batch delete request
            try managedContext.execute(batchDeleteRequest)
            
            // Save changes to persist the deletion
            try managedContext.save()
        } catch let error as NSError {
            print("Error deleting all data: \(error), \(error.userInfo)")
        }
    }
    
}

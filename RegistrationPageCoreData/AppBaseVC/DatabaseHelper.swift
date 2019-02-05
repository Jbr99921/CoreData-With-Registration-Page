//
//  DatabaseHelper.swift
//  RegistrationPageCoreData
//
//  Created by MacMiniOld on 12/11/18.
//  Copyright © 2018 Xongolab. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class DatabaseHelper:NSObject{
    
    static let shareInstance = DatabaseHelper()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func getContext() -> NSManagedObjectContext{
        let appdeleget = UIApplication.shared.delegate as! AppDelegate
        return appdeleget.persistentContainer.viewContext
    }
    func getById(id: NSManagedObjectID) -> NSManagedObject{
        let context = getContext()
        return context.object(with: id)
    }
     func dataByUniqueID(uniqueId: String) -> [RegistrationDetails]
    {
        var result = [RegistrationDetails]()
        let fetchRequest: NSFetchRequest = RegistrationDetails.fetchRequest()
        let predicate = NSPredicate(format: "uniqueId== %@","\(uniqueId)")
        fetchRequest.predicate = predicate
        do{
            result = try getContext().fetch(fetchRequest)
        }catch{
            print(error.localizedDescription)
        }
        return result
    }
     func updateRecord(id: NSManagedObjectID, dictionary: [String:Any]){
        let context = getContext()
        let sugerToUpdate = getById(id: id)
        sugerToUpdate.setValuesForKeys(dictionary)
        do{
            try context.save()
            print("Update Register....")
        }catch{
            print(error.localizedDescription)
        }
    }
    func clearCoreData()
    {
        let fetchRequest:NSFetchRequest<RegistrationDetails> = RegistrationDetails.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest as! NSFetchRequest<NSFetchRequestResult>)
        do{
            print("deleting all elements")
            try getContext().execute(deleteRequest)
        }
        catch
        {
            print("error in clear data = \(error.localizedDescription)")
        }
    }
    
    
    
    func Save(object:[String:Any]){
   
        var imgFromDB:UIImage?
        let appdel = getContext()
        let entity = NSEntityDescription.insertNewObject(forEntityName: "RegistrationDetails", into: context) as! RegistrationDetails
        entity.firstName = object["firstName"] as? String
        entity.lastName = object["lastName"] as? String
        entity.user = object["user"] as? String
        entity.email = object["email"] as? String
        entity.password = object["password"] as? String
        entity.uniqueId = object["uniqueId"] as? String
   //     entity.imgUser = object["imgUser"] as? NSData
        let image =  entity.setValue(imgFromDB, forKey: "imgUser")
        entity.imgUser = object["imgUser"] as! NSData
        do{
            try context.save()
        }catch{
            print("Data not save")
        }
    }
    func GetShowData() -> [RegistrationDetails]{
        var AllRecords = [RegistrationDetails]()
        let fetchRequest:NSFetchRequest = RegistrationDetails.fetchRequest()
//        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "RegistrationDetails")
        do{
            AllRecords = try getContext().fetch(fetchRequest)
        }catch{
            print("Not get data")
        }
        return AllRecords
    }
    func getID(Id:NSManagedObjectID)->NSManagedObject{
        let appDel:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let context:NSManagedObjectContext = appDel.persistentContainer.viewContext
        return context.object(with:Id)
    }
    func update(Id:NSManagedObjectID,dictionary:[String:String]){
        let appDel:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let context:NSManagedObjectContext = appDel.persistentContainer.viewContext
        let updateRecord = getID(Id: Id)
        updateRecord.setValuesForKeys(dictionary)
        do{
            try context.save()
        }catch{
            print(error.localizedDescription)
        }
    }
}

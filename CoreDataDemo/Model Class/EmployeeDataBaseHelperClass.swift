//
//  DataBaseHelperClass.swift
//  CoreDataDemo
//
//  Created by iT Gurus Software on 01/06/20.
//  Copyright © 2020 iT Gurus Software. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class EmpDatabaseHelper {
    
    static let shareInstance = EmpDatabaseHelper()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.newBackgroundContext()
    let moc = NSManagedObjectContextConcurrencyType.mainQueueConcurrencyType
//    let privateMOC = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
//    privateMOC.parentContext = moc

    
    func save(object:[String:String]){
        let entityName = NSEntityDescription.insertNewObject(forEntityName: "Employee", into: context)as! Employee
        entityName.empId = object["empId"]
        entityName.empName = object["empName"]
        do{
            try self.context.save()
        }catch{
            print("Data Not Save")
        }    
    }
    
    func getEmployeeData()->[Employee]{
        var employee:[Employee] = []
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Employee")
        do{
            employee = try context.fetch(fetchRequest) as! [Employee]
        }catch{
            print("Data Not Show")
        }
       return employee
    }
    
    func deleteData(index:Int)->[Employee]{
        var employee = getEmployeeData()
        context.delete(employee[index])
        employee.remove(at: index)
        do{
            try context.save()
        }catch{
            print("Can not delete data")
        }
        return employee
    }
    
    func editData(object:[String:String], i:Int){
        let employee = getEmployeeData()
        employee[i].empName = object["empName"]
        employee[i].empId = object["empId"]
        do{
            try context.save()
        }catch{
            print("Can not Edit data")
        }
    
    }
}

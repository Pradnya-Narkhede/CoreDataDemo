//
//  EmployeeDetailDataBase.swift
//  CoreDataDemo
//
//  Created by iT Gurus Software on 01/06/20.
//  Copyright © 2020 iT Gurus Software. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class EmpDetailDatabaseHelper {
    
    static let shareInstance = EmpDetailDatabaseHelper()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    static var selectedEmp : Employee!
    
    func save(object:[String:String]){
        let entityName = NSEntityDescription.insertNewObject(forEntityName: "EmployeeDetail", into: context)as! EmployeeDetail
        entityName.empAddr = object["empAddr"]
        entityName.empPhone = object["empPhone"]
        entityName.ofEmp = EmpDetailDatabaseHelper.selectedEmp
        do{
            try context.save()
        }catch{
            print("Data Not Save")
        }
    
    }
    func getEmployeeData()->[EmployeeDetail]{
        var employee:[EmployeeDetail] = []
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName:"EmployeeDetail")
        do{
            employee = try context.fetch(fetchRequest) as! [EmployeeDetail]
        }catch{
            print("Data Not Show")
        }
        return employee
    }
    func deleteData(index:Int)->[EmployeeDetail]{
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
}

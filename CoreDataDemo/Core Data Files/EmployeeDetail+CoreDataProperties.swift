//
//  EmployeeDetail+CoreDataProperties.swift
//  CoreDataDemo
//
//  Created by iT Gurus Software on 01/06/20.
//  Copyright © 2020 iT Gurus Software. All rights reserved.
//
//

import Foundation
import CoreData


extension EmployeeDetail {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<EmployeeDetail> {
        return NSFetchRequest<EmployeeDetail>(entityName: "EmployeeDetail")
    }

    @NSManaged public var empAddr: String?
    @NSManaged public var empPhone: String?
    @NSManaged public var ofEmp: Employee?

}


//
//  DisplayEmpDetailViewController.swift
//  CoreDataDemo
//
//  Created by iT Gurus Software on 01/06/20.
//  Copyright © 2020 iT Gurus Software. All rights reserved.
//

import UIKit
import CoreData
struct EmpModel {
    var name = ""
    var id = ""
    var phone = ""
    var address = ""
    init() {
    }
}
class DisplayEmpDetailViewController: UIViewController {
    
    @IBOutlet weak var lblOfEmpId: UILabel!
    @IBOutlet weak var lblOfEmpName: UILabel!
    @IBOutlet weak var lblOfEmpPhone: UILabel!
    @IBOutlet weak var lblOfEmpAddr: UILabel!
    var empModel = EmpModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Employee Detail"
        lblOfEmpId.text = empModel.id
        lblOfEmpName.text = empModel.name
        lblOfEmpAddr.text = empModel.address
        lblOfEmpPhone.text = empModel.phone
    }
    
}

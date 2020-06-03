//
//  DisplayEmpViewController.swift
//  CoreDataDemo
//
//  Created by iT Gurus Software on 01/06/20.
//  Copyright © 2020 iT Gurus Software. All rights reserved.
//

import UIKit
protocol DataPass {
    func data(object:[String:String],index:Int,isEdit:Bool)
}

class DisplayEmpViewController: UIViewController {
    
    @IBOutlet weak var tableOfEmp: UITableView!
    var empArr = [Employee]()
    var empDetailArr = [EmployeeDetail]()
    var delegate : DataPass!
    // var dele = DataPass.self
    
    override func viewDidLoad() {
        super.viewDidLoad()
        empArr = EmpDatabaseHelper.shareInstance.getEmployeeData()
    }
}

extension DisplayEmpViewController : UITableViewDataSource,UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return empArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style:.default, reuseIdentifier: "cell")
        cell.textLabel?.text = empArr[indexPath.row].empName
        cell.accessoryType = .detailButton
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let empDetailVC = storyboard?.instantiateViewController(identifier: "DisplayEmpDetailViewController")as! DisplayEmpDetailViewController
        var emp = EmpModel()
        
        if let name = empArr[indexPath.row].empName{
            emp.name = name
        }
        if let id = empArr[indexPath.row].empId{
            emp.id = id
        }
        if let address = empArr[indexPath.row].has?.empAddr{
            emp.address = address
        }
        if let phone =  empArr[indexPath.row].has?.empPhone{
            emp.phone = phone
        }
        empDetailVC.empModel = emp
        self.navigationController?.pushViewController(empDetailVC, animated: true)
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            empArr = EmpDatabaseHelper.shareInstance.deleteData(index: indexPath.row)
            self.tableOfEmp.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        print("Tapped")
        let dict = ["empName":empArr[indexPath.row].empName!,"empId":empArr[indexPath.row].empId!]
        
        if let editData = delegate{
            editData.data(object: dict , index:indexPath.row, isEdit: true)
        }
        else{
            print("nil")
        }
        self.navigationController!.popToRootViewController(animated: true)
        
    }
}

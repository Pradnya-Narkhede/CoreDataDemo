//
//  ViewController.swift
//  CoreDataDemo
//
//  Created by iT Gurus Software on 01/06/20.
//  Copyright © 2020 iT Gurus Software. All rights reserved.
//

import UIKit

class EmployeeViewController: UIViewController,DataPass {
    
    @IBOutlet weak var txtEmpName: UITextField!
    @IBOutlet weak var txtEmpId: UITextField!
    @IBOutlet weak var btnSave: UIButton!
    
    var tempArr = [Employee]()
    var i = Int()
    var isUpdate = Bool()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        tempArr = EmpDatabaseHelper.shareInstance.getEmployeeData()
    }
    
    @IBAction func btnSaveClick(_ sender: Any) {
        let dict:[String:String]=["empId":self.txtEmpId.text!,"empName":self.txtEmpName.text!]
        if txtEmpName.text!.isEmpty && txtEmpId.text!.isEmpty{
            let alert = UIAlertController(title: "Invalid", message: "Please Enter Data", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        if isUpdate {
            EmpDatabaseHelper.shareInstance.editData(object: dict , i: i)
        }else{
            EmpDatabaseHelper.shareInstance.save(object: dict )
        }
        
        let alert = UIAlertController(title: "Alert", message: "Employee Data Saved Successfully", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: { _ in
        }))
        alert.addAction(UIAlertAction(title: "OK",style: UIAlertAction.Style.default,
                                      handler: {(_: UIAlertAction!) in
                                        self.txtEmpName.text = ""
                                        self.txtEmpId.text = ""
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func btnEditClick(_ sender: Any) {
    let vc = storyboard?.instantiateViewController(identifier:"DisplayEmpViewController")as! DisplayEmpViewController
      vc.delegate = self
     self.navigationController?.pushViewController(vc, animated: true)
    }
    func data(object: [String : String], index: Int, isEdit: Bool) {
        txtEmpName.text = object["empName"]
        txtEmpId.text = object["empId"]
        i = index
        isUpdate = isEdit
    }
}

extension EmployeeViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(EmployeeViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}


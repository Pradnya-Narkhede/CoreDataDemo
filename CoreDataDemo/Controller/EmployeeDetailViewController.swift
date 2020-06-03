//
//  EmployeeDetailViewController.swift
//  CoreDataDemo
//
//  Created by iT Gurus Software on 01/06/20.
//  Copyright © 2020 iT Gurus Software. All rights reserved.
//

import UIKit
import CoreData

class EmployeeDetailViewController: UIViewController{
    
    @IBOutlet weak var empNamePickerView: UIPickerView!
    @IBOutlet weak var txtEmpPhone: UITextField!
    @IBOutlet weak var txtEmpAddr: UITextField!
    @IBOutlet weak var btnSave: UIButton!
    
    var empArr = [Employee]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        empArr = EmpDatabaseHelper.shareInstance.getEmployeeData()
        //empDetailArr = EmpDetailDatabaseHelper.shareInstance.getEmployeeData()
    }
    
    @IBAction func btnSaveClick(_ sender: Any) {
        let dict:[String:String]=["empPhone":txtEmpPhone.text!,"empAddr":txtEmpAddr.text!]
        if txtEmpPhone.text!.isEmpty && txtEmpAddr.text!.isEmpty{
            let alert = UIAlertController(title: "Invalid", message: "Please Enter Data", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        EmpDetailDatabaseHelper.shareInstance.save(object: dict)
        let alert = UIAlertController(title: "Alert", message: "Employee Details Data Saved Successfully", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: { _ in
        }))
        alert.addAction(UIAlertAction(title: "OK",style: UIAlertAction.Style.default,
                                      handler: {(_: UIAlertAction!) in
                                        self.txtEmpAddr.text = ""
                                        self.txtEmpPhone.text = ""
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
}
//Picker View
extension EmployeeDetailViewController : UIPickerViewDataSource,UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return empArr.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return empArr[row].empName
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let temp = empArr[row]
        EmpDetailDatabaseHelper.selectedEmp = temp
    }
    
}
extension EmployeeDetailViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(EmployeeDetailViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

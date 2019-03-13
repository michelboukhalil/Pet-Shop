//
//  ProfileViewController.swift
//  Pet Shop
//
//  Created by Michel Bou khalil on 2/15/19.
//  Copyright © 2019 Michel Bou khalil. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ProfileViewController: UITableViewController {
    
    var formArray = [formRow]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let location = CLLocationCoordinate2D(latitude: 51.50007773,
//                                              longitude: -0.1246402)
//        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
//        let region = MKCoordinateRegion(center: location, span: span)
//        mapAddress.setRegion(region, animated: true)
//        let annotation = MKPointAnnotation()
//        annotation.coordinate = location
//        annotation.title = "Big Ben"
//        annotation.subtitle = "London"
//        mapAddress.addAnnotation(annotation)
        

        do {
            let row = formRow.init(title: "Profile", type: cellsTypes.label.rawValue,value: "")
            formArray.append(row)
        }
        
        let row2 = formRow.init(title: "Marital Status", type: cellsTypes.checkButtons.rawValue, value: "Married")
        formArray.append(row2)
        let row3 = formRow.init(title: "", type: cellsTypes.checkButtons.rawValue, value: "Widowed")
        formArray.append(row3)
        let row4 = formRow.init(title: "", type: cellsTypes.checkButtons.rawValue, value: "Single")
        formArray.append(row4)
        let row5 = formRow.init(title: "Sexe", type: cellsTypes.checkButtons.rawValue, value: "Male")
        formArray.append(row5)
        let row6 = formRow.init(title: "", type: cellsTypes.checkButtons.rawValue, value: "Female")
        formArray.append(row6)
        let row7 = formRow.init(title: "Income", type: cellsTypes.checkButtons.rawValue, value: "Monthly")
        formArray.append(row7)
        let row8 = formRow.init(title: "", type: cellsTypes.checkButtons.rawValue, value: "Yearly")
        formArray.append(row8)
        let row9 = formRow.init(title: "", type: cellsTypes.checkButtons.rawValue, value: "Weekly")
        formArray.append(row9)
        let row10 = formRow.init(title: "", type: cellsTypes.checkButtons.rawValue, value: "none")
        formArray.append(row10)
        let row11 = formRow.init(title: "Extra Income", type: cellsTypes.switchControl.rawValue, value: "")
        formArray.append(row11)
        let row12 = formRow.init(title: "Phone Number : ", type: cellsTypes.textField.rawValue, value: "")
        formArray.append(row12)
        let row13 = formRow.init(title: "Age", type: cellsTypes.textField.rawValue, value: "")
        formArray.append(row13)
        let row14 = formRow.init(title: "Address", type: cellsTypes.mapView.rawValue, value: "")
        formArray.append(row14)
    
    }
    
    @IBAction func checkBox(_ sender: UIButton) {

        UIView.animate(withDuration: 0.1, delay: 0.1, options: .curveLinear, animations: {
            sender.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        
            
        }) { (success) in
            UIView.animate(withDuration: 0.1, delay: 0.1, options: .curveLinear, animations: {
                sender.isSelected = !sender.isSelected
                sender.transform = .identity
            }, completion: nil)
        }
        
        
    
//        if sender.isSelected == marriedButton.isSelected {
//            widowedButton.isSelected = false
//            singleButton.isSelected = false
//            User.userInfo.maritalStatus = "Married"
//        } else if sender.isSelected == widowedButton.isSelected {
//            marriedButton.isSelected = false
//            singleButton.isSelected = false
//            User.userInfo.maritalStatus = "Widowed"
//        } else if sender.isSelected == singleButton.isSelected {
//            marriedButton.isSelected = false
//            widowedButton.isSelected = false
//            User.userInfo.maritalStatus = "Single"
//        } else{
//            print("nothing is selected")
//        }


}
    
    
//    @IBAction func sexeCheckBox(_ sender: UIButton) {
//
//        UIView.animate(withDuration: 0.1, delay: 0.1, options: .curveLinear, animations: {
//            sender.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
//
//
//        }) { (success) in
//            UIView.animate(withDuration: 0.1, delay: 0.1, options: .curveLinear, animations: {
//                sender.isSelected = !sender.isSelected
//                sender.transform = .identity
//            }, completion: nil)
//        }
//
//        if sender.isSelected == maleButton.isSelected {
//            femaleButton.isSelected = false
//            User.userInfo.sexe = true
//        } else if sender.isSelected == femaleButton.isSelected {
//            maleButton.isSelected = false
//            User.userInfo.sexe = false
//        }
//    }
    
    
    
//    @IBAction func incomeCheckBox(_ sender: UIButton) {
//
//        UIView.animate(withDuration: 0.1, delay: 0.1, options: .curveLinear, animations: {
//            sender.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
//
//
//        }) { (success) in
//            UIView.animate(withDuration: 0.1, delay: 0.1, options: .curveLinear, animations: {
//                sender.isSelected = !sender.isSelected
//                sender.transform = .identity
//            }, completion: nil)
//        }
//
//        if sender.isSelected == monthlyButton.isSelected {
//            yearlyButton.isSelected = false
//            weeklyButton.isSelected = false
//            noIncomeButton.isSelected = false
//            User.userInfo.income = "Monthly"
//        } else if sender.isSelected == yearlyButton.isSelected {
//            monthlyButton.isSelected = false
//            weeklyButton.isSelected = false
//            noIncomeButton.isSelected = false
//            User.userInfo.income = "Yearly"
//        } else if sender.isSelected == weeklyButton.isSelected {
//            yearlyButton.isSelected = false
//            monthlyButton.isSelected = false
//            noIncomeButton.isSelected = false
//            User.userInfo.income = "Weekly"
//        } else if sender.isSelected == noIncomeButton.isSelected {
//
//            yearlyButton.isSelected = false
//            weeklyButton.isSelected = false
//            monthlyButton.isSelected = false
//            User.userInfo.income = "No Income"
//        }
//
//        if  sender.tag == 1 && noIncomeButton.isSelected == false {
//            extraIncome.isHidden = false
//            extraIncomeText.isHidden = false
//        } else{
//            extraIncome.isHidden = true
//            extraIncomeText.isHidden = true
//        }
//
//      print(sender.tag)
//        print(noIncomeButton.isSelected)
//
//    }
    
//    @IBAction func extraIncomeButton(_ sender: UIButton) {
//
//        if extraIncome.isOn {
//            User.userInfo.extraIncome = true
//        } else {
//            User.userInfo.extraIncome = false
//        }
//
//
//    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return formArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let currentItem = formArray[indexPath.row]
        switch currentItem.type {
        case cellsTypes.label.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: "labelCell", for: indexPath) as! Cells
            cell.titleText.text = currentItem.title
            return cell
            
        case cellsTypes.checkButtons.rawValue :
            let cell = tableView.dequeueReusableCell(withIdentifier: "buttonCell", for: indexPath) as! Cells
            cell.optionLabel.text = currentItem.title
            cell.statusLabel.text = currentItem.value
            cell.statusButton.setImage(UIImage(named: "Checkmark"), for: .selected)
            cell.statusButton.setImage(UIImage(named: "Checkmarkempty"), for: .normal)
            return cell
            
        case cellsTypes.switchControl.rawValue :
            let cell = tableView.dequeueReusableCell(withIdentifier: "switchCell", for: indexPath) as! Cells
            
            cell.switchText.text = currentItem.title
            
            return cell
        
            
        case cellsTypes.textField.rawValue :
            let cell = tableView.dequeueReusableCell(withIdentifier: "textFieldCell", for: indexPath) as! Cells
            cell.textFieldLabel.text = currentItem.title
            
            return cell
            
        case cellsTypes.mapView.rawValue :
            let cell = tableView.dequeueReusableCell(withIdentifier: "addressCell", for: indexPath) as! Cells
            
            cell.addressLabel.text = currentItem.title
            return cell 
            
        default: break

        }
        
        let cell2 = tableView.dequeueReusableCell(withIdentifier: "saveCell", for: indexPath) as! Cells
        
        
        return cell2


//        return tableView.dequeueReusableCell(withIdentifier: "labelCell", for: indexPath) as! Cells
    }

}

class Cells : UITableViewCell {
    
    @IBOutlet weak var switchText: UILabel!
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var optionLabel: UILabel!
    @IBOutlet weak var statusButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var switchStatus: UISwitch!
    @IBOutlet weak var textFieldLabel: UILabel!
    @IBOutlet weak var textFieldText: UITextField!
    @IBOutlet weak var addressLabel: UILabel!
}


    


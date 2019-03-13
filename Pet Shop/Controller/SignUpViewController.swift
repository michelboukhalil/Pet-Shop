//
//  SignUpViewController.swift
//  Pet Shop
//
//  Created by Michel Bou khalil on 2/11/19.
//  Copyright © 2019 Michel Bou khalil. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SignUpViewController: UIViewController {
    

    let URL = "https://eurisko-push.herokuapp.com/parse/functions/createAccount"
    let APP_ID = "HsYqu0zBI93H0mmDLkyHYb4TvJWSwtqQt59TiJ4v"
    
    @IBOutlet weak var loadingActivity: UIActivityIndicatorView!
    @IBOutlet weak var fullName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myColor = UIColor.white
        email.layer.borderColor = myColor.cgColor
        password.layer.borderColor = myColor.cgColor
        confirmPassword.layer.borderColor = myColor.cgColor
        fullName.layer.borderColor = myColor.cgColor
        
        fullName.layer.borderWidth = 1.5
        email.layer.borderWidth = 1.5
        password.layer.borderWidth = 1.5
        confirmPassword.layer.borderWidth = 1.5
        
        
        
    }
    
    @IBAction func signUpButton(_ sender: Any) {
        
        
        let fullName = self.fullName.text!
        let email = self.email.text!
        let password = self.password.text!
        let confirmPassword = self.confirmPassword.text!
        
        if validation(fullName: fullName, email: email, password: password, confirmPassword: confirmPassword) == true{

        signUpAuthentication()

        }
    }
    
    func validation(fullName:String,email:String,password:String,confirmPassword:String) -> Bool{
        if isValidEmail(email){
            self.email.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            print("Email is valid")
            
            if isValidPassword(password){
                self.password.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                print("Password is valid")
                
                if password == confirmPassword {
                    self.confirmPassword.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                    print("Match")
                    
                    if fullName == ""{
                        print("Empty full name")
                        self.fullName.layer.borderColor = #colorLiteral(red: 1, green: 0.2007186711, blue: 0.3067349792, alpha: 1)
                        return false
                        
                    }else {
                        print("Correct full name")
                        self.fullName.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                        return true
                    }
                }else {
                    self.confirmPassword.layer.borderColor = #colorLiteral(red: 1, green: 0.2007186711, blue: 0.3067349792, alpha: 1)
                    print("Doesn't match")
                    return false
                }
            }else {
                self.password.layer.borderColor = #colorLiteral(red: 1, green: 0.2007186711, blue: 0.3067349792, alpha: 1)
                print("Password is invalid")
                return false
            }
            
        }else{
            self.email.layer.borderColor = #colorLiteral(red: 1, green: 0.2007186711, blue: 0.3067349792, alpha: 1)
            return false
        }
        
        
    }
    
    
    func signUpAuthentication(){
        
        let params = [
            "email" : self.email!.text,
            "password" : self.password!.text,
            "full_name" : self.fullName!.text
            
        ]
        
        loadingActivity.startAnimating()
        
        Alamofire.request(URL,
                          method : .post,
                          parameters : params as Parameters,
                          headers: ["X-Parse-Application-Id": self.APP_ID, "Content-Type":" application/x-www-form-urlencoded"]
            ).responseJSON { response in
                self.loadingActivity.stopAnimating()
            guard response.result.isSuccess, let value = response.result.value else {
                   fatalError("Connection Lost")
            }
                
               
                
                if ((response.response?.statusCode)!) == 200 {
                    
                    let id = JSON(value)["result"]["objectId"].rawString()
                    
                    UserDefaults.standard.set(id, forKey: "id")
                    UserDefaults.standard.set(true, forKey: "status")
                    UserDefaults.standard.synchronize()
                    Switcher.updateRootVC()
    
                
                } else {
                    let alert = UIAlertController(title: "Error", message: "Email already exist", preferredStyle: .alert)
                    
                    let action = UIAlertAction(title: "Okay", style: .default)
                    
                    alert.addAction(action)
                    
                    self.present(alert, animated: true, completion: nil)
                }

        }
        
    }
        
}

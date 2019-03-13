//
//  ViewController.swift
//  Pet Shop
//
//  Created by Michel Bou khalil on 2/11/19.
//  Copyright © 2019 Michel Bou khalil. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import FacebookLogin
import FacebookCore
import CoreData


class LogInViewController: UIViewController  {
    
    var userID : String?
    var user = User()
    var currentUser : CurrentUser?
    var pets : ListView?

    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    @IBOutlet weak var fbLogin: UIButton!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    let URL = "https://eurisko-push.herokuapp.com/parse/functions/authinticate"
    let APP_ID = "HsYqu0zBI93H0mmDLkyHYb4TvJWSwtqQt59TiJ4v"
    
    @IBOutlet weak var loadingActivity: UIActivityIndicatorView!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myColor = UIColor.white
        email.layer.borderColor = myColor.cgColor
        password.layer.borderColor = myColor.cgColor
        
        email.layer.borderWidth = 1.5
        password.layer.borderWidth = 1.5
        
        let loginButton = LoginButton(readPermissions: [ .publicProfile ])
        loginButton.center = view.center
//        fbLogin.buttonType = loginButton
        view.addSubview(loginButton)

        
        guard let accessToken = AccessToken.current else { return }
        
        if accessToken.userId != "" {
            UserDefaults.standard.set(true, forKey: "status")
            
            Switcher.updateRootVC()
        }
        
       
        
    }
    
    
    @IBAction func signInButton(_ sender: Any) {
        
        let email = self.email.text!
        let password = self.password.text!
        
        if isValidEmail(email){
            print("Email is valid")
            self.email.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            
            if isValidPassword(password){

            }else {
                print("Password is invalid")
            }
            
        }else{
            self.email.layer.borderColor = #colorLiteral(red: 1, green: 0.2007186711, blue: 0.3067349792, alpha: 1)
            print("Email is invalid")
            
        }
 
    loginInAuthentication()

    }

    func loginInAuthentication() {
        
        let params = [
            "email" : self.email!.text,
            "password" : self.password!.text
            
        ]

        //show
        loadingActivity.startAnimating()
        
        Alamofire.request(URL,
                          method : .post,
                          parameters : params as Parameters,
                          headers: ["X-Parse-Application-Id": self.APP_ID,
                                    "Content-Type":" application/x-www-form-urlencoded"]
            ).responseJSON { response in
                //hide
                self.loadingActivity.stopAnimating()
            guard response.result.isSuccess,
                let value = response.result.value else {
                    fatalError("Failed")
            }
            
                if (response.response?.statusCode)! < 400 {
                    
                    let id = JSON(value)["result"]["objectId"].rawString()
                    UserDefaults.standard.set(id, forKey: "id")
                    UserDefaults.standard.synchronize()
                    UserDefaults.standard.set(true, forKey: "status")
                    
                    Switcher.updateRootVC()
                } else {
                     let alert = UIAlertController(title: "Error", message: "Wrong username or/and password", preferredStyle: .alert)
                    
                    let action = UIAlertAction(title: "Okay", style: .default)
                    
                    alert.addAction(action)
                    
                    self.present(alert, animated: true, completion: nil)
                }
       
           

        }

    }
    

    }

func isValidEmail(_ email:String) -> Bool {
    
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailTest.evaluate(with: email)
}

func isValidPassword(_ password:String) -> Bool {
    
    let passwordRegEx = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{6,}$"
    let passwordTest = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
    return passwordTest.evaluate(with: password)
    
}




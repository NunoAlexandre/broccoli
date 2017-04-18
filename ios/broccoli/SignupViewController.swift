//
//  SignupViewController.swift
//  broccoli
//
//  Created by Nuno on 18/04/2017.
//  Copyright © 2017 nunoalexandre. All rights reserved.
//

import Foundation
import Eureka
import Alamofire

class SignupViewController : FormViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        form +++ Section()
            <<< NameRow() {
                    $0.tag = "name"
                    $0.title = "Name"
                    $0.placeholder = "your name goes here"
                    $0.add(rule: RuleRequired())
                    $0.validationOptions = .validatesOnChange
                }
                .cellUpdate { cell, row in
                    if !row.isValid {
                        cell.titleLabel?.textColor = .red
                    }
                }
            <<< EmailRow() {
                    $0.tag = "email"
                    $0.title = "Email"
                    $0.placeholder = "your email goes here"
                    $0.add(rule: RuleRequired())
                    $0.add(rule: RuleEmail())
                }
                .cellUpdate { cell, row in
                    if !row.isValid {
                        cell.titleLabel?.textColor = .red
                    }
                }
            <<< PasswordRow() {
                    $0.tag = "password"
                    $0.title = "Password"
                    $0.placeholder = "your password gos here"
                    $0.add(rule: RuleRequired())
                    $0.add(rule: RuleMinLength(minLength: 8))
                }
                .cellUpdate { cell, row in
                    if !row.isValid {
                        cell.titleLabel?.textColor = .red
                    }
                }
            <<< ButtonRow() {
                    $0.title = "Signup"
                }.onCellSelection {  cell, row in
                    let parameters: [String: Any] = ["user": ["name" : self.form.values()["name"] as! String, "email" : self.form.values()["email"] as! String, "password" : self.form.values()["password"] as! String]]
                    
                    Alamofire.request("http://192.168.178.206:4000/api/users", method: .post, parameters: parameters, encoding: JSONEncoding.default)
                        .responseJSON { response in print(response) }

                }
    }
    
    override func loadView() {
        super.loadView()
        view.translatesAutoresizingMaskIntoConstraints = false
    }
    
}

//
//  FirstViewController.swift
//  broccoli
//
//  Created by Nuno on 17/04/2017.
//  Copyright © 2017 nunoalexandre. All rights reserved.
//

import UIKit
import Alamofire
import Eureka

class LoginViewController : FormViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        form +++ Section() { section in
                var customSection = HeaderFooterView<UIView>(.class)
                customSection.onSetupView = { view, section in
                    view.backgroundColor = .white
                }
                section.header = customSection
                section.header?.height = {0}
                section.footer = customSection
                section.footer?.height = {60}
                section.reload()
            }
            <<< EmailRow() {
                $0.tag = "email"
                $0.title = "Email"
                $0.placeholder = "your email goes here"
                $0.add(rule: RuleRequired())
                $0.add(rule: RuleEmail())
            }
            .cellUpdate { cell, row in
                if !row.isValid { cell.titleLabel?.textColor = .red }
            }
            <<< PasswordRow() {
                $0.tag = "password"
                $0.title = "Password"
                $0.placeholder = "password"
                $0.add(rule: RuleRequired())
                $0.add(rule: RuleMinLength(minLength: 8))
            }
            <<< ButtonRow() { row in
                    row.title = "Login"
                    row.cell.height = {90}
                }
                .onCellSelection {  cell, row in
                    let parameters = ["credentials": ["email" : self.form.values()["email"] as! String,
                                                      "password" : self.form.values()["password"] as! String]]
                    
                    Alamofire.request("http://192.168.178.206:4000/api/authenticate", method: .post, parameters: parameters, encoding: JSONEncoding.default)
                        .responseJSON { response in
                            print(response)
                            if let status = response.response?.statusCode {
                                switch(status) {
                                case 200:
                                    let alert = UIAlertController(title: "Authenticated!",
                                                            message: "Hi broccoli! :)",
                                                                  preferredStyle: .alert)
                                    alert.addAction(UIAlertAction(title: "Yay", style: .default, handler: { (action) -> Void in }))
                                    self.present(alert, animated: true, completion: nil)
                                case 404:
                                    let alert = UIAlertController(title: "Ups!",
                                                                  message: "Invalid credentials...",
                                                                  preferredStyle: .alert)
                                    alert.addAction(UIAlertAction(title: "Oke", style: .default, handler: { (action) -> Void in }))
                                    self.present(alert, animated: true, completion: nil)
                                default:
                                    print("error with response status: \(status)")
                                }
                            }
                            
                    }
        }

        
        
//        Alamofire.request("http://192.168.178.206:4000/api/users").responseJSON { response in
//            print(response.request ?? "no request")  // original URL request
//            print(response.response ?? "no response") // HTTP URL response
//            print(response.data ?? "no data")     // server data
//            print(response.result)   // result of response serialization
//            
//            if let JSON = response.result.value {
//                print("JSON: \(JSON)")
//            }
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


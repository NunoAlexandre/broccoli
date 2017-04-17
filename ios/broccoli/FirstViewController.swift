//
//  FirstViewController.swift
//  broccoli
//
//  Created by Nuno on 17/04/2017.
//  Copyright © 2017 nunoalexandre. All rights reserved.
//

import UIKit
import Alamofire

class FirstViewController: UIViewController {
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!

    @IBAction func signup(_ sender: UIButton) {
        let parameters: [String: Any] = ["user": ["name" : name.text!, "email" : email.text!, "password" : password.text!]]
        
        Alamofire.request("http://192.168.178.206:4000/api/users", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON { response in print(response) }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        Alamofire.request("http://192.168.178.206:4000/api/users").responseJSON { response in
            print(response.request ?? "no request")  // original URL request
            print(response.response ?? "no response") // HTTP URL response
            print(response.data ?? "no data")     // server data
            print(response.result)   // result of response serialization
            
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


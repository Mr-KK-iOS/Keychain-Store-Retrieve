//
//  ViewController.swift
//  Keychain Store
//
//  Created by Admin on 10/13/20.
//  Copyright © 2020 Kaustabh. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    @IBOutlet weak var nameTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    
    
    @IBOutlet weak var saveBtn: UIButton!{
        didSet{
            self.saveBtn.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMinXMinYCorner]
            self.saveBtn.roundCorners(corners: [.topLeft,.topRight])
        }
    }
    
    @IBAction func saveBtnAction(_ sender: UIButton) {
        if self.nameTxtField.text?.isEmpty ?? true {
            self.presentAlert(withTitle: "Warning", message: "User Name/Email Address is required")
        }
        else if self.passwordTxtField.text?.isEmpty ?? true {
            self.presentAlert(withTitle: "Warning", message: "Password is required")
        }
        else {
            let username : String = "\(self.nameTxtField.text ?? "")"
            let password : String = "\(self.passwordTxtField.text ?? "")"
            let userinfo : [String : String] = ["name" : self.nameTxtField.text ?? "","password" : self.passwordTxtField.text ?? ""]
            let dataExample: Data = try! NSKeyedArchiver.archivedData(withRootObject: userinfo, requiringSecureCoding: false)
            
            let userdata = Data(from: username)
            let passworddata = Data(from: password)
            let _ = KeychainManager.save(key: "Username", data: userdata)
            let _ = KeychainManager.save(key: "password", data: passworddata)
            let _ = KeychainManager.save(key: "userdetails", data: dataExample)
        
        }
    }
    
    
    //N.B :- Use NSKeyedArchiver.archivedData(withRootObject: _, requiringSecureCoding: _) to Store Dictionary, Array or Custom Class/Structure
    
    
    @IBAction func fetchDataAction(_ sender: UIButton) {
        
        ///to(type : _) must match the type you have saved already in your keychain like Int,String,Dictionary etc.
        
        /// Retrieve String Value Keychain
        if let receivedData = KeychainManager.load(key: "Username") {
            let result = receivedData.to(type: String.self)
            print("result Username: ", result)
        }
        
        /// Retrieve String Value Keychain
        if let receivedData = KeychainManager.load(key: "password") {
            let result = receivedData.to(type: String.self)
            print("result password: ", result)
        }
        
        /// Retrive Dictionary Stored in Keychain
        if let receivedData = KeychainManager.load(key: "userdetails") {
            let data = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(receivedData) as? [String : String]
            print("result userdetails : ", data ?? [:])
        }

        
    }
    
    //N.B :- Use NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(_) as? (Type) to Store Dictionary, Array or Custom Class/Structure
    
    //N.B: - Use receivedData.to(type: _.self) of KeychainManager Class to Retrieve Single Value like String, Int, Bool etc.

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

extension UIViewController {

    func presentAlert(withTitle title: String = "" , message : String = "") {
        let alertController = UIAlertController(title: title , message: message, preferredStyle: .alert)
    let OKAction = UIAlertAction(title: "OK", style: .default) { action in
        print("Ok button completion handler")
    }
    let CANCELAction = UIAlertAction(title: "CANCEL", style: .destructive, handler: { action in
        print("CANCEL button completion handler")
    })
    alertController.addAction(OKAction)
    alertController.addAction(CANCELAction)
    self.present(alertController, animated: true, completion: nil)
  }
}

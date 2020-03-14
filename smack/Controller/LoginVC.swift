//
//  LoginVC.swift
//  smack
//
//  Created by Biasi on 3/13/18.
//  Copyright © 2018 Biasi. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    @IBOutlet weak var passwordTxt: UITextField!
    
    @IBOutlet weak var userNameTxt: UITextField!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        // Do any additional setup after loading the view.
    }

    
    @IBAction func loginPressed(_ sender: Any) {
        spinner.isHidden = false
        spinner.startAnimating()
        
        guard let email = userNameTxt.text , userNameTxt.text != "" else{return}
        guard let pass = passwordTxt.text , passwordTxt.text != "" else{return}
        
        AuthService.instance.loginUser(email: email, password: pass) { (success) in
            if success {                
                AuthService.instance.findUserByEmail(completion: { (success) in
                    if success{
                        NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
                        self.spinner.isHidden = true
                        self.spinner.stopAnimating()
                        self.dismiss(animated: true, completion: nil)
                    }
                })
            }
        }



    }
    
    @IBAction func closepressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
   
    @IBAction func dontHaveAcctPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_CREATE_ACCOUNT, sender: nil)
    }
    
    /// do sometjing
    func setUpView(){
        spinner.isHidden = true
        userNameTxt.attributedPlaceholder = NSAttributedString(string: "username", attributes: [NSAttributedStringKey.foregroundColor: smackPurpleColor])
        passwordTxt.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSAttributedStringKey.foregroundColor: smackPurpleColor])
        
    }
    
}













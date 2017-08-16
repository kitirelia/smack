//
//  LoginVC.swift
//  Smack
//
//  Created by kitiwat chanluthin on 8/15/17.
//  Copyright © 2017 kitiwat chanluthin. All rights reserved.
//

import UIKit
import SVProgressHUD

class LoginVC: UIViewController {

    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    @IBAction func closePressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func createAccountBtnPressed(_ sender: UIButton) {
        
        performSegue(withIdentifier: TO_CREATE_ACCOUNT, sender: nil)
    }
    
    @IBAction func loginPressed(_ sender: Any) {
        
        guard let username = usernameTxt.text , usernameTxt.text != ""
        else{
            return
        }
        guard let password = passwordTxt.text,passwordTxt.text != "" else {
            return
        }
        
        SVProgressHUD.show()
        AuthService.instance.loginUser(email: username, password: password) { (result) in
            if result{
                print("login complete")
                SVProgressHUD.showSuccess(withStatus: "Login Success")
            }else{
                print("login fail!!")
                
                SVProgressHUD.showError(withStatus: "Login Failed")
            }
        }
        
    }
    
}

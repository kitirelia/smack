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
        setupView()
        
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
        AuthService.instance.loginUser(email: username, password: password) { (loginSuccess) in
            SVProgressHUD.dismiss()
            if loginSuccess{
                AuthService.instance.findUserByEmail(completion: { (findByEmailSuccess) in
                    if findByEmailSuccess{
                        SVProgressHUD.showSuccess(withStatus: "Login Success")
                        NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
                        SVProgressHUD.dismiss(withDelay: 2, completion: {
                            self.dismiss(animated: true, completion: nil)
                        })
                    }
                })
            }else{
                print("login fail!!")
                
                SVProgressHUD.showError(withStatus: "Login Failed")
            }
        }
    }
    
    func setupView(){
        usernameTxt.attributedPlaceholder = NSAttributedString(string: "username", attributes: [NSAttributedStringKey.foregroundColor:smackPurplePlaceHolder])
        passwordTxt.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSAttributedStringKey.foregroundColor:smackPurplePlaceHolder])
    }
    
}

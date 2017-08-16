//
//  CreateAccountVC.swift
//  Smack
//
//  Created by kitiwat chanluthin on 8/15/17.
//  Copyright © 2017 kitiwat chanluthin. All rights reserved.
//

import UIKit
import SVProgressHUD

class CreateAccountVC: UIViewController {

    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var userImg: UIImageView!
    
    //Variables
    var avatarName = "profileDefault"
    var avatarColor = "[0.5,0.5,0.5,1]"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func pickAvatarPressed(_ sender: Any) {
    }
    
    @IBAction func closePressed(_ sender: UIButton) {
        performSegue(withIdentifier: UNWIND, sender: nil)
    }
    @IBOutlet weak var pickBgColorPressed: UIButton!
    
    @IBAction func registerBtnPressed(_ sender: Any) {
        guard  let username = usernameTxt.text ,usernameTxt.text != "" else {
            return
        }
        guard  let email = emailTxt.text, emailTxt.text != "" else {
            return
        }
        guard let password = passwordTxt.text, passwordTxt.text != "" else{
            return
        }
        SVProgressHUD.show()
        AuthService.instance.registerUser(email: email, password: password) { (success) in
            SVProgressHUD.dismiss()
            SVProgressHUD.show()
            if success{
                SVProgressHUD.showSuccess(withStatus: "register success")
                SVProgressHUD.dismiss()
                SVProgressHUD.show()
                AuthService.instance.createUser(name: username, email: email, avatarName: self.avatarName, avatarColor: self.avatarColor, completion:{(success) in
                    SVProgressHUD.dismiss()
                    if success{
                        SVProgressHUD.showSuccess(withStatus: "Update User Success")
                        
                        SVProgressHUD.dismiss (completion: {
                            self.performSegue(withIdentifier: UNWIND, sender: nil)
                        })
                    }else{
                        SVProgressHUD.showError(withStatus: "Error Add user")
                    }
                })
                print("registered user!")
            }else{
                SVProgressHUD.showError(withStatus: "register fail")
                print("register user Error!")
            }
        }
    }
}

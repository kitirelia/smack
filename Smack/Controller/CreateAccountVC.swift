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
        
        guard  let email = emailTxt.text, emailTxt.text != "" else {
            return
        }
        guard let password = passwordTxt.text, passwordTxt.text != "" else{
            return
        }
        SVProgressHUD.show()
        AuthService.instance.registerUser(email: email, password: password) { (success) in
            if success{
                SVProgressHUD.showSuccess(withStatus: "register success")
                print("registered user!")
            }else{
                SVProgressHUD.showError(withStatus: "register fail")
                print("register user Error!")
            }
        }
    }
}

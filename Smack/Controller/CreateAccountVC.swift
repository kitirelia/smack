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
    var bgColor : UIColor?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if UserDataService.instance.avatarName != ""{
            userImg.image = UIImage(named:UserDataService.instance.avatarName)
            avatarName = UserDataService.instance.avatarName
            if avatarName.contains("light") && bgColor == nil{
                userImg.backgroundColor = UIColor.lightGray
            }
        }
    }

    @IBAction func pickAvatarPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_AVATAR_PICKER, sender: nil)
    }
    
    @IBAction func closePressed(_ sender: UIButton) {
        performSegue(withIdentifier: UNWIND, sender: nil)
    }
    
    func setupView(){
        usernameTxt.attributedPlaceholder = NSAttributedString(string: "username", attributes: [NSAttributedStringKey.foregroundColor:smackPurplePlaceHolder])
        emailTxt.attributedPlaceholder = NSAttributedString(string: "email", attributes: [NSAttributedStringKey.foregroundColor:smackPurplePlaceHolder])
        passwordTxt.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSAttributedStringKey.foregroundColor:smackPurplePlaceHolder])
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(CreateAccountVC.handleTap))
        view.addGestureRecognizer(tap)
        
    }
    
    
    @objc func handleTap(){
        view.endEditing(true)
    }
    
    @IBAction func generColorBtnPressed(_ sender: Any) {
        let r = CGFloat(arc4random_uniform(255)) / 255
        let g = CGFloat(arc4random_uniform(255)) / 255
        let b = CGFloat(arc4random_uniform(255)) / 255
        
        bgColor = UIColor(red: r, green: g, blue: b, alpha: 1)
        avatarColor = "[\(r),\(g),\(b),1]"
        UIView.animate(withDuration: 0.2) {
            self.userImg.backgroundColor = self.bgColor
        }
        
    }
    
    
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
            if success{
                AuthService.instance.loginUser(email: email, password: password, completion: { (loginSuccss) in
                    if loginSuccss{
                        AuthService.instance.createUser(name: username, email: email, avatarName: self.avatarName, avatarColor: self.avatarColor, completion: { (addUserSucess) in
                            if addUserSucess{
                                SVProgressHUD.showSuccess(withStatus: "Update User Success")
                                
                                SVProgressHUD.dismiss (completion: {
                                    NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
                                    self.performSegue(withIdentifier: UNWIND, sender: nil)
                                })
                            }else{
                                SVProgressHUD.showError(withStatus: "Error Add user")
                            }
                        })
                        
                    }
                })
            }else{
                SVProgressHUD.showError(withStatus: "register fail")
                print("register user Error!")
            }
        }
    }
    
    
    
}

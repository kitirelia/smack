//
//  ChannelVC.swift
//  Smack
//
//  Created by kitiwat chanluthin on 8/14/17.
//  Copyright © 2017 kitiwat chanluthin. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController {

    
    @IBOutlet weak var userImage: CircleImage!
    @IBOutlet weak var loginBtn: UIButton!
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue){}
    override func viewDidLoad() {
        super.viewDidLoad()
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.userDataDidChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
    }
    override func viewDidAppear(_ animated: Bool) {
        setupUserInfo()
    }
    
    @IBAction func loginBtnPress(_ sender: UIButton) {
        if AuthService.instance.isLoggedIn{
            //Show Profile Page
            print(AuthService.instance.userEmail)
            let profile =  ProfileVC()
            profile.modalPresentationStyle = .custom
            present(profile, animated: true, completion: nil)
        }
        else{
            performSegue(withIdentifier: TO_LOGIN, sender: nil)
        }
        
    }
    
    @objc func userDataDidChange(_ notif:Notification){
        print("Channel VC Observer")
        setupUserInfo()
    }
    
    func setupUserInfo(){
        if AuthService.instance.isLoggedIn{
            loginBtn.setTitle("\(UserDataService.instance.name)", for: .normal)
            userImage.image = UIImage(named:UserDataService.instance.avatarName)
            userImage.backgroundColor = UserDataService.instance.returnUIColor(component: UserDataService.instance.avatarColor)
            
            // UserDataService.instance.avatarColor
        }else{
            loginBtn.setTitle("Login", for: .normal)
            userImage.image = UIImage(named: "menuProfileIcon")
            userImage.backgroundColor = UIColor.clear
        }
    }
    
}

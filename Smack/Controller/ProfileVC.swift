//
//  ProfileVC.swift
//  Smack
//
//  Created by kitiwat chanluthin on 8/16/17.
//  Copyright © 2017 kitiwat chanluthin. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {

    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var bgView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    func setupView(){
        print("setup view \(UserDataService.instance.email)")
        userEmail.text = UserDataService.instance.email
        userName.text = UserDataService.instance.name
        profileImage.image = UIImage(named:UserDataService.instance.avatarName)
        profileImage.backgroundColor = UserDataService.instance.returnUIColor(component: UserDataService.instance.avatarColor)
        let closeTap = UITapGestureRecognizer(target:self,action: #selector(ProfileVC.closeTap(_:)))
        bgView.addGestureRecognizer(closeTap)
    }
    
    @objc func closeTap(_ gesture:UITapGestureRecognizer){
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func logOutPressed(_ sender: Any) {
        UserDataService.instance.logoutUser()
        NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func closeModalPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}

//
//  ChannelVC.swift
//  Smack
//
//  Created by kitiwat chanluthin on 8/14/17.
//  Copyright © 2017 kitiwat chanluthin. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var userImage: CircleImage!
    @IBOutlet weak var loginBtn: UIButton!
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue){}
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        print("set data source")
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.userDataDidChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
    }
    override func viewDidAppear(_ animated: Bool) {
        setupUserInfo()
    }
    @IBAction func addChannellPressed(_ sender: Any) {
        let addChannel = AddChannelVC()
        addChannel.modalPresentationStyle = .custom
        present(addChannel,animated:true,completion:nil)
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
            //tableView.reloadData()
            // UserDataService.instance.avatarColor
        }else{
            loginBtn.setTitle("Login", for: .normal)
            userImage.image = UIImage(named: "menuProfileIcon")
            userImage.backgroundColor = UIColor.clear
        }
    }
    
}

extension ChannelVC:UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "channelCell", for: indexPath) as? ChannelCell{
//            let channel = MessageService.instance.channels[indexPath.row]
            let channel = MessageService.instance.dummyData()[indexPath.row]
            cell.configureCell(channel: channel)
            return cell
        }else{
            return ChannelCell()
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return MessageService.instance.channels.count
        return MessageService.instance.dummyData().count
    }

}

extension ChannelVC:UITableViewDelegate{
    
}

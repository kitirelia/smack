//
//  ChatVC.swift
//  Smack
//
//  Created by kitiwat chanluthin on 8/14/17.
//  Copyright © 2017 kitiwat chanluthin. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {

    //Outlet
    
    @IBOutlet weak var typingUserLbl: UILabel!
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var messageTxt: UITextField!
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var channelNameLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var isTyping:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.bindToKeyboard()
        
        tableView.delegate = self 
        tableView.dataSource = self
        
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableViewAutomaticDimension
        
        sendBtn.isHidden = true
        typingUserLbl.text = ""
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        let tap = UITapGestureRecognizer(target: self, action: #selector(ChatVC.handleTap))
        view.addGestureRecognizer(tap)
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.userDataDidChange(_:)),name:NOTIF_USER_DATA_DID_CHANGE  ,object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.channelSelected), name: NOTIF_CHANNEL_SELECTED, object: nil)
        
        SocketService.instance.getChatMessage { (success) in
            if success{
                self.tableView.reloadData()
                if MessageService.instance.messages.count>0{
                    let endIndex = IndexPath(row: MessageService.instance.messages.count-1, section: 0)
                    self.tableView.scrollToRow(at: endIndex, at:.bottom, animated: true)
                }
            }
        }
        
        SocketService.instance.getTypingUser { (typingUsers) in
            guard let channelId = MessageService.instance.selectedChannel?.id else{ return }
            
            var names = ""
            var numberOfTypers = 0
            
            for (typingUser,channel) in typingUsers{
                if typingUser != UserDataService.instance.name && channel == channelId {
                    if names == ""{
                        names = typingUser
                    }else{
                        names = "\(names), \(typingUser)"
                    }
                    numberOfTypers += 1
                }
            }
            
            if numberOfTypers > 0 && AuthService.instance.isLoggedIn == true{
                var verb = "is"
                if numberOfTypers > 1{
                    verb = "are"
                }
                self.typingUserLbl.text = "\(names) \(verb) typing a message"
            }else{
                self.typingUserLbl.text = ""
            }
        }
        
        if AuthService.instance.isLoggedIn{
            AuthService.instance.findUserByEmail(completion: { (success) in
               // print("-- token --")
               // print("Bearer \(AuthService.instance.authToken)")
               // print("-----------")
                NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
            })
        }
    }
    
    @objc func handleTap(){
        view.endEditing(true)
    }
    
    @objc func channelSelected(_ notif:Notification){
       updateWithChannel()
    }
    @objc func userDataDidChange(_ notif:Notification){
        if AuthService.instance.isLoggedIn{
            onLoginGetMessages()
        }else{
            channelNameLbl.text = "Please Log In"
            tableView.reloadData()
        }
    }
    
    func updateWithChannel(){
        let channelName = MessageService.instance.selectedChannel?.channelTitle ?? ""
        channelNameLbl.text = "#\(channelName)"
        getMessages()
    }
    
    
    @IBAction func messageBoxEditing(_ sender: Any) {
        guard  let channelId = MessageService.instance.selectedChannel?.id else {return}
        if messageTxt.text == ""{
            isTyping = false
            sendBtn.isHidden = true
            SocketService.instance.socket.emit("stopType", UserDataService.instance.name,channelId)
        }else{
            if isTyping == false{
                sendBtn.isHidden = false
                SocketService.instance.socket.emit("startType", UserDataService.instance.name,channelId)
            }
            isTyping = true
        }
    }
    
    @IBAction func sendMessagePressed(_ sender: Any) {
        if AuthService.instance.isLoggedIn{
            guard let channelId = MessageService.instance.selectedChannel?.id else {return}
            guard let message = messageTxt.text,messageTxt.text != "" else {return}
            
            SocketService.instance.addMessage(messageBody: message, userId: UserDataService.instance.id, channelId: channelId, completion: { (success) in
                if success{
                    self.messageTxt.text = ""
                    self.messageTxt.resignFirstResponder()
                    SocketService.instance.socket.emit("stopType", UserDataService.instance.name,channelId)
                }
            })
        }
    }
    
    func onLoginGetMessages(){
        MessageService.instance.findAllChannel(completion: { (success) in
            if success{
                if MessageService.instance.channels.count > 0 {
                    MessageService.instance.selectedChannel = MessageService.instance.channels[0]
                    self.updateWithChannel()
                }else{
                    self.channelNameLbl.text = "No channels yet!"
                }
            }
        })
    }
    
    
    func getMessages(){
        guard  let channelId = MessageService.instance.selectedChannel?.id else {
            return
        }
        MessageService.instance.findAllMessagesForChannel(channelId: channelId) { (success) in
            if success{
                // load request
                self.tableView.reloadData()
            }
        }
    }
   

}
extension ChatVC:UITableViewDelegate{
    
}

extension ChatVC:UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath) as? MessageCell{
            let message = MessageService.instance.messages[indexPath.row]
            cell.configureCell(message: message)
            return cell
        }else{
            return MessageCell()
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.messages.count
    }
}


//
//  SocketService.swift
//  Smack
//
//  Created by kitiwat chanluthin on 8/17/17.
//  Copyright © 2017 kitiwat chanluthin. All rights reserved.
//

import UIKit
import SocketIO

class SocketService: NSObject {
    static let instance = SocketService()
    
    override init() {
        super.init()
    }
    
    var socket : SocketIOClient = SocketIOClient(socketURL:URL(string:BASE_URL)!)
    
    func establishConnection(){
        socket.connect()
    }
    
    func closeConnecttion(){
        socket.disconnect()
    }
    
    func addChannel(channelName:String,channelDesc:String,completion: @escaping CompletionHandler){
        socket.emit("newChannel", channelName,channelDesc)
        completion(true)
    }
    
    func getChannel(completion:@escaping CompletionHandler){
        socket.on("channelCreated") { (dataArray, ack) in
                  
            guard let channelName = dataArray[0] as? String else {return}
            guard let channelDesc = dataArray[1] as? String else {return}
            guard let channelId = dataArray[2] as? String else {return}
            
            let newChannel = Channel(channelTitle: channelName, channelDescription: channelDesc, id: channelId)
            MessageService.instance.channels.append(newChannel)
            completion(true)
        }
    }
    
    func addMessage(messageBody:String,userId:String,channelId:String,completion:@escaping CompletionHandler){
        let user = UserDataService.instance
        socket.emit("newMessage", messageBody,userId,channelId,user.name,user.avatarName,user.avatarColor)
        
        completion(true)
        
    }
    
//    func getChatMessage(completion:@escaping CompletionHandler){
    func getChatMessage(completion:@escaping (_ newMessage:Message) -> Void){
        socket.on("messageCreated") { (dataArray, ack) in
            guard let msgBody = dataArray[0] as? String else{return}
            guard let channelId = dataArray[2] as? String else{return}
            guard let userName = dataArray[3] as? String else{return}
            guard let userAvatar   = dataArray[4] as? String else{return}
            guard let userAvatarColor = dataArray[5] as? String else{return}
            guard let msgId = dataArray[6] as? String else{return}
            guard let timeStamp = dataArray[7] as? String else{return}
            
            let newMessage = Message(message: msgBody, userName: userName, channelId: channelId, userAvatar: userAvatar, userAvatarColor: userAvatarColor, id: msgId, timeStamp: timeStamp)
            
            completion(newMessage)
//            if channelId == MessageService.instance.selectedChannel?.id && AuthService.instance.isLoggedIn{
//
//
//            MessageService.instance.messages.append(newMessage)
//                completion(true)
//            }
//            else{
//                completion(false)
//            }
        }
    }
    
    func getTypingUser(_ completionHandler:@escaping (_ typingUsers:[String:String])->Void){
        socket.on("userTypingUpdate") { (dataArray, ack) in
            guard let typingUser = dataArray[0] as? [String:String] else {return}
            completionHandler(typingUser)
        }
    }
    
    
    
}//end class

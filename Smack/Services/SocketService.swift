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
    
    
}

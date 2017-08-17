//
//  MessageService.swift
//  Smack
//
//  Created by kitiwat chanluthin on 8/17/17.
//  Copyright © 2017 kitiwat chanluthin. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MessageService{
    
    static let instance = MessageService()
    
    var channels = [Channel]()
    
    func findAllChannel(completion:@escaping CompletionHandler){
        
        Alamofire.request(URL_GET_CHANNEL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            
            if response.result.error == nil{
                
                guard let data = response.data else {return}
                if let json = JSON(data:data).array{
                    for item in json{
                        let name = item["name"].stringValue
                        let channelDescription = item["description"].stringValue
                        let id = item["_id"].stringValue
                        let channel = Channel(channelTitle: name, channelDescription: channelDescription, id: id)
                        self.channels.append(channel)
                    }
                    completion(true)
                }
                
            }else{
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func dummyData()->[Channel]{
        var dummy = [Channel]()
        dummy.append(Channel(channelTitle: "arsenal", channelDescription: "arsenal desc", id: "01"))
        dummy.append(Channel(channelTitle: "liverpool", channelDescription: "liverpool desc", id: "02"))
        dummy.append(Channel(channelTitle: "everton", channelDescription: "everton desc", id: "03"))
        dummy.append(Channel(channelTitle: "westham", channelDescription: "westham utd desc", id: "04"))
        dummy.append(Channel(channelTitle: "crystal palace", channelDescription: "crystal palace desc", id: "05"))
        dummy.append(Channel(channelTitle: "millwall", channelDescription: "millwall desc", id: "06"))
        
        return dummy
    }
    
}

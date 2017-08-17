//
//  MessageCell.swift
//  Smack
//
//  Created by kitiwat chanluthin on 8/17/17.
//  Copyright © 2017 kitiwat chanluthin. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet weak var userImage: CircleImage!
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var timestampLbl: UILabel!
    @IBOutlet weak var messageBodyLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    func configureCell(message:Message){
        messageBodyLbl.text = message.message
        timestampLbl.text = message.timeStamp
        usernameLbl.text = message.userName
        userImage.image = UIImage(named:message.userAvatar)
        userImage.backgroundColor = UserDataService.instance.returnUIColor(component: message.userAvatarColor)
    }

}

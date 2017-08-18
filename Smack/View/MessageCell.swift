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
        guard var isoDate = message.timeStamp else{ return }
        let end = isoDate.index(isoDate.endIndex, offsetBy: -5)
        isoDate = isoDate.substring(to: end)
        
        let isoFormatter = ISO8601DateFormatter()
        let chatDate = isoFormatter.date(from: isoDate.appending("Z"))
        let newFormatter = DateFormatter()
        newFormatter.dateFormat = "MMM d,h:mm a"
        if let finalDate = chatDate{
            let finalDate = newFormatter.string(from: finalDate)
            timestampLbl.text = finalDate
        }
    }

}

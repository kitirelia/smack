//
//  avatarCell.swift
//  Smack
//
//  Created by kitiwat chanluthin on 8/16/17.
//  Copyright © 2017 kitiwat chanluthin. All rights reserved.
//

import UIKit

enum AvatarType {
    case dark
    case light
}

class AvatarCell: UICollectionViewCell {
    
    @IBOutlet weak var avatarImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }
    
    func configueCell(indexPath:Int,type:AvatarType){
        if type == AvatarType.dark{
            avatarImage.image = UIImage(named:"dark\(indexPath)")
            self.layer.backgroundColor = UIColor.lightGray.cgColor
        }else{
            avatarImage.image = UIImage(named:"light\(indexPath)")
            self.layer.backgroundColor = UIColor.gray.cgColor
        }
        
    }
    
    func setUpView(){
        self.layer.backgroundColor = UIColor.lightGray.cgColor
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }
    
}

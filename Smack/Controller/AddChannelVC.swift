//
//  AddChannelVC.swift
//  Smack
//
//  Created by kitiwat chanluthin on 8/17/17.
//  Copyright © 2017 kitiwat chanluthin. All rights reserved.
//

import UIKit

class AddChannelVC: UIViewController {

    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var chanDesc: UITextField!
    @IBOutlet weak var bgView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view.
    }

    
    

    @IBAction func createChannelPressed(_ sender: Any) {
        guard let channelName = nameTxt.text, nameTxt.text != "" else{ return }
        guard let chanDesc = chanDesc.text else { return }
        
        SocketService.instance.addChannel(channelName: channelName, channelDesc: chanDesc) { (success) in
            if success{
                self.dismiss(animated: true, completion: nil)
            }
        }
        
    }
    
    
    @IBAction func closeModalPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func setupView(){
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(AddChannelVC.closeTap(gesture:)))
        bgView.addGestureRecognizer(closeTouch)
        
        nameTxt.attributedPlaceholder = NSAttributedString(string: "name", attributes: [NSAttributedStringKey.foregroundColor:smackPurplePlaceHolder])
        chanDesc.attributedPlaceholder = NSAttributedString(string: "description", attributes: [NSAttributedStringKey.foregroundColor:smackPurplePlaceHolder])
    }
    
    @objc func closeTap(gesture:UITapGestureRecognizer){
         
    }
    
}

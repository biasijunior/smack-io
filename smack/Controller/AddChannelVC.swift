//
//  AddChannelVC.swift
//  smack
//
//  Created by Biasi on 3/30/18.
//  Copyright © 2018 Biasi. All rights reserved.
//

import UIKit

class AddChannelVC: UIViewController {


    @IBOutlet weak var nameTxt: UITextField!
    
    @IBOutlet weak var chanDesc: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    @IBOutlet weak var bgView: UIView!
    
    @IBAction func closeModelPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
   
    @IBAction func createChannelPressed(_ sender: Any) {
        
        guard let channelName = nameTxt.text , nameTxt.text != "" else {return}
//        channelName = String(channelName)
        guard let channelDesc = chanDesc.text , chanDesc.text != "" else {return}
//        channelDesc = String(channelDesc)
        SocketService.instance.addChannel(channelName: channelName, channelDiscription: channelDesc) { (success) in
            if success {
                self.dismiss(animated: true, completion: nil)
            }
        }

    }
    
    func setupView(){
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(AddChannelVC.closeTap(_:)))
        bgView.addGestureRecognizer(closeTouch)
        
        nameTxt.attributedPlaceholder = NSAttributedString(string: "name", attributes: [NSAttributedStringKey.foregroundColor : smackPurpleColor])
        
          chanDesc.attributedPlaceholder = NSAttributedString(string: "description", attributes: [NSAttributedStringKey.foregroundColor : smackPurpleColor])
        
        
        
        
    }
    
    @objc func closeTap(_ recognizer: UITapGestureRecognizer){
        dismiss(animated: true, completion: nil )
    }
    
    
    
    
    
    
    
}

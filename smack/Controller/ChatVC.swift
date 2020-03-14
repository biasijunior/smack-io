//
//  ChatVC.swift
//  smack
//
//  Created by Biasi on 3/12/18.
//  Copyright © 2018 Biasi. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {
    
//outlets
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var leftAnchor: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
    }
    
  

}

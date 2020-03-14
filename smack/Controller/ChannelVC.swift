//
//  ChannelVC.swift
//  smack
//
//  Created by Biasi on 3/12/18.
//  Copyright © 2018 Biasi. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController, UITableViewDelegate, UITableViewDataSource{
//outlest
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var userImg: CircleImage!
    @IBOutlet weak var tableView: UITableView!
    //ib actions
    
    @IBAction func addChannelPressed(_ sender: Any) {
        
        let addChannel = AddChannelVC()
        addChannel.modalPresentationStyle = .custom
        present(addChannel, animated: true, completion: nil)
    }
    
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue){
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 80
        revealViewController().rightViewRevealWidth = 80 - self.view.frame.size.width
//        self.revealViewController().rearViewRevealOverdraw = 0;
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.userDataDidCahnage(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        SocketService.instance.getChannel { (success) in
            if success {
                self.tableView.reloadData()
            }
        }
    }
    
    let darkView = UIView()

    override func viewWillAppear(_ animated: Bool) {

        darkView.addGestureRecognizer(revealViewController().tapGestureRecognizer())
        darkView.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        darkView.frame = self.revealViewController().frontViewController.view.bounds
        self.revealViewController().frontViewController.view.addSubview(darkView)
    }

    override func viewWillDisappear(_ animated: Bool) {
        darkView.removeFromSuperview()
    }

    @IBAction func loginBtnPressed(_ sender: Any) {
        if AuthService.instance.isLoggedIn {
           //show profile page
            let profile = ProfileVC()
            profile.modalPresentationStyle = .custom
            present(profile, animated: true, completion: nil)
        }else{
             performSegue(withIdentifier: TO_LOGIN, sender: nil)
        }
    }
    
    @objc func userDataDidCahnage(_ notif: Notification){
        if AuthService.instance.isLoggedIn {
            loginBtn.setTitle(UserDataService.instance.name, for: .normal)
            userImg.image = UIImage(named: UserDataService.instance.avatarName)
            userImg.backgroundColor = UserDataService.instance.returnUIColor(components: UserDataService.instance.avatarColor)
        }else{
            loginBtn.setTitle("Login", for: .normal)
            userImg.image = UIImage(named: "menuProfileIcon")
            userImg.backgroundColor = UIColor.clear
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "channelcell ", for: indexPath ) as? ChannelCell {
            
            let channel = MessageService.instance.channels[indexPath.row]
            cell.configureCell(channel: channel )
            return cell
        }else{
            return UITableViewCell()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.channels.count
    }
    
    
    
}
















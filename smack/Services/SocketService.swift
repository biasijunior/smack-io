//
//  SocketService.swift
//  smack
//
//  Created by Biasi on 4/6/18.
//  Copyright © 2018 Biasi. All rights reserved.
//

import UIKit
import SocketIO

class SocketService: NSObject {
    
    static let instance = SocketService()
    
    override init() {
        super.init()
    }

    let socket : SocketManager = SocketManager(socketURL : URL(string: BASE_URL)!)
    
    func establishConnection(){
        let conn = socket.defaultSocket
        conn.connect()
    }
    
    func  closeConnection(){
        let conn = socket.defaultSocket
        conn.disconnect()
    }
    
    func addChannel(channelName: String, channelDiscription:  String, completion: @escaping ComplitionHandler){
        let conn = socket.defaultSocket
        conn.emit("newChannel", channelName, channelDiscription)
        completion(true)
        
    }
    
    func getChannel(completion: @escaping ComplitionHandler){
        let conn = socket.defaultSocket
        conn.on("channelCreated") { (dataArray, ack) in
            
            guard let channelName = dataArray[0] as? String else{return}
            guard let channelDesc = dataArray[1] as? String else{return}
            guard let channelId = dataArray[2] as? String else{return}
            let v = 0
            
            let newChannel = Channel(_id: channelId, name: channelName, description: channelDesc, __v: v as! Int)
            
            MessageService.instance.channels.append(newChannel)
            
            completion(true)

            
        }
        
        
//        conn.on("channelCreated"){(dataArray, ack) in
//            guard let channelName = dataArray[0] as? String else{return}
//            guard let channelDesc = dataArray[1] as? String else{return}
//            guard let channelId = dataArray[2] as? String else{return}
//            let v = dataArray[3]
//
//            let newChannel = Channel(_id: channelId, name: channelName, description: channelDesc, __v: v as? Int)
//
//            MessageService.instance.channels.append(newChannel)
//
//            completion(true)

            
            
        
    }
    
}










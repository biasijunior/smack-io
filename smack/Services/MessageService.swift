//
//  MessageService.swift
//  smack
//
//  Created by Biasi on 3/24/18.
//  Copyright © 2018 Biasi. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
class MessageService{
    static let instance = MessageService()
    
    var channels = [Channel]()
    
    func findAllChannel(completion: @escaping ComplitionHandler) {
        Alamofire.request(URL_GET_CHANNELS, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            if response.result.error == nil {
                guard let data = response.data else {return }

                do{
                     self.channels = try JSONDecoder().decode([Channel].self, from: data)
                }catch let error{
                    debugPrint(error as Any)
                }
                print(self.channels)

                
            }else{
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
}

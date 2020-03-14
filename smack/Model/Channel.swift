//
//  Channel.swift
//  smack
//
//  Created by Biasi on 3/24/18.
//  Copyright © 2018 Biasi. All rights reserved.
//

import Foundation
struct Channel: Decodable  {
    public private(set) var _id: String!
    public private(set) var name: String!
    public private(set) var description: String!
    public private(set) var __v: Int?
}

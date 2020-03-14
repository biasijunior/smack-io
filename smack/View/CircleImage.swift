//
//  CircleImage.swift
//  smack
//
//  Created by Biasi on 3/17/18.
//  Copyright © 2018 Biasi. All rights reserved.
//

import UIKit
@IBDesignable //let us see the results inside the storybord
class CircleImage: UIImageView {

    override func awakeFromNib() {
        setupView()
    }
    
    func setupView(){
        self.layer.cornerRadius = self.frame.width / 2
        self.clipsToBounds = true
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }
    
}

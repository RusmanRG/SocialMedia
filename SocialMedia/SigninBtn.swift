//
//  SigninBtn.swift
//  SocialMedia
//
//  Created by Russell G Stewart on 2017-03-04.
//  Copyright © 2017 App Whole. All rights reserved.
//

import UIKit

class SigninBtn: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
    layer.shadowColor = UIColor(red: SHADOW_GREY, green: SHADOW_GREY, blue: SHADOW_GREY, alpha: 0.6).cgColor
    layer.shadowOpacity = 0.8
    layer.shadowRadius = 5.0
    layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
    layer.cornerRadius = 2.0
    
    }
}

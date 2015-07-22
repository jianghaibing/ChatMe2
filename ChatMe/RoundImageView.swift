//
//  RoundImageView.swift
//  ChatMe
//
//  Created by baby on 15/7/22.
//  Copyright © 2015年 Beijing Gold Finger Education Technology LLC. All rights reserved.
//

import UIKit

@IBDesignable class RoundImageView: UIImageView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    @IBInspectable override var cornerRadius:CGFloat {
      didSet{
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = (cornerRadius > 0)
        }
    }
    
    @IBInspectable var borderWith:CGFloat = 0.0 {
        didSet{
            layer.borderWidth = borderWith
        }
    }
    
    @IBInspectable var borderColor:UIColor?{
        didSet{
            layer.borderColor = borderColor?.CGColor
        }
    }

}

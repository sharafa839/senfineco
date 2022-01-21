//
//  UILabel+Ex.swift
//  Sokyakom
//
//  Created by Ghoost on 10/4/20.
//

import UIKit
import MOLH


extension UILabel {
    
    
    
    func initLabel(title:String,titleColor :UIColor , backgroundColor:UIColor,roundCorner :CGFloat,fontSize:CGFloat , alignment : NSTextAlignment? = nil) {
        
        if alignment != nil {
            self.textAlignment = alignment!
        }else{
            switch MOLHLanguage.currentAppleLanguage() {
            case "ar":
                self.textAlignment = .right
            default:
                self.textAlignment = .left
            }
        }
        
        self.text = title.localizede
        self.textColor = titleColor
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = roundCorner
        self.clipsToBounds = true
       // self.font = UIFont(name:UIFont().familyName, size: fontSize)
        
    }
    
    func labelLocalization() {
        switch MOLHLanguage.currentAppleLanguage() {
        case "ar":
            self.textAlignment = .right
        default:
            self.textAlignment = .left
        }
    }
    
    
    
    
    
    
}

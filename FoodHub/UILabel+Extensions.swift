//
//  UILabel+Extensions.swift
//  FoodHub
//
//  Created by Moataz Mohamed on 12/01/2024.
//

import UIKit

extension UILabel{
    enum LabelType{
        case title
        case subTitle(font:CGFloat)
    }
    
    func configure(with type: LabelType, text: String) {
        switch type {
        case .title:
            self.font = UIFont.boldSystemFont(ofSize: 36)
            self.textColor = .black
            
        case .subTitle(let subTitleFont):
            self.font = UIFont.systemFont(ofSize: subTitleFont)
            self.textColor = UIColor(hex: 0x9796A1)
        }
        
        self.text = text
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
}





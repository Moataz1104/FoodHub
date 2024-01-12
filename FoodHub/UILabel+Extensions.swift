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
        case subTitle
    }
    
    func configure(with type: LabelType, text: String, font: CGFloat = 14) {
        switch type {
        case .title:
            self.font = UIFont.boldSystemFont(ofSize: 36)
            self.textColor = .black
            
        case .subTitle:
            self.font = UIFont.systemFont(ofSize: font)
            self.textColor = UIColor(hex: 0x9796A1)
        }
        
        self.text = text
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
}





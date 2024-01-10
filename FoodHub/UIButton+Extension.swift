//
//  UIButton+Extension.swift
//  FoodHub
//
//  Created by Moataz Mohamed on 10/01/2024.
//

import UIKit

extension UIButton {
    
    enum type {
        case facebook
        case google
    }
    
    func setButton(_ type: type) -> UIButton {
        let button = UIButton(type: .system)
        
        switch type {
        case .facebook:
            configureButton(button, imageName: "FaceBookLogo", title: "FACEBOOK", backgroundColor: .white)
            
        case .google:
            configureButton(button, imageName: "GoogleLogo", title: "Google", backgroundColor: .white)
        }
        
        return button
    }
    
    private func configureButton(_ button: UIButton, imageName: String, title: String, backgroundColor: UIColor) {
        button.setImage(UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.backgroundColor = backgroundColor
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        button.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func mainButton(_ title:String)-> UIButton{
        let button = UIButton(type: .system)
        button.setTitle("LOGIN", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        button.layer.cornerRadius=28.5
        button.backgroundColor = UIColor(hex: 0xFE724C)
        button.setTitleShadowColor(UIColor(hex: 0x7A81BE29).withAlphaComponent(16), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints=false
        
        return button
    }
}

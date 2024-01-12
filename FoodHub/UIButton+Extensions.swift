//
//  UIButton+Extension.swift
//  FoodHub
//
//  Created by Moataz Mohamed on 10/01/2024.
//

import UIKit

extension UIButton {
    
    enum AuthButton {
        case facebook
        case google
    }
    
    func setButton(for type:AuthButton) -> UIButton {
        let button = UIButton(type: .system)
        switch type {
        case .facebook:
            configureButton(button, imageName: "FaceBookLogo", title: "FACEBOOK")
            
        case .google:
            configureButton(button, imageName: "GoogleLogo", title: "Google")
        }
        
        return button
    }
    
    private func configureButton(_ button: UIButton, imageName: String, title: String) {
        button.setImage(UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.backgroundColor = .white
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        button.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    static var mainButton:UIButton {
        let button = UIButton(type: .system)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        button.layer.cornerRadius=28.5
        button.backgroundColor = UIColor(hex: 0xFE724C)
        button.setTitleShadowColor(UIColor(hex: 0x7A81BE29).withAlphaComponent(16), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints=false
        
        return button
    }
}

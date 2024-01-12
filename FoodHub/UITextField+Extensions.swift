//
//  UITextField+Extensions.swift
//  FoodHub
//
//  Created by Moataz Mohamed on 12/01/2024.
//


import UIKit

extension UITextField {
    
    enum FieldType {
        case username
        case email
        case password(enableVisibilityToggle: Bool)
    }
    
    func configure(with type: FieldType) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = .always
        self.layer.cornerRadius = 10
        self.borderStyle = .roundedRect
        self.translatesAutoresizingMaskIntoConstraints = false
        
        switch type {
        case .username:
            self.placeholder = "Your Name"
        case .email:
            self.placeholder = "Your E-mail"
        case .password(let enableVisibilityToggle):
            self.placeholder = "Password"
            self.isSecureTextEntry = true
            if enableVisibilityToggle {
                addPasswordVisibilityButton()
            }
        }
    }
    
    private func addPasswordVisibilityButton() {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        button.tintColor = .lightGray
        button.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
        
        self.rightView = button
        self.rightViewMode = .always
    }
    
    @objc private func togglePasswordVisibility() {
        self.isSecureTextEntry = !self.isSecureTextEntry
        let imageName = self.isSecureTextEntry ? "eye.slash" : "eye"
        if let visibilityButton = self.rightView as? UIButton {
            visibilityButton.setImage(UIImage(systemName: imageName), for: .normal)
        }
        
        if let existingText = self.text, self.isSecureTextEntry {
            self.deleteBackward()
            if let textRange = self.textRange(from: self.beginningOfDocument, to: self.endOfDocument) {
                self.replace(textRange, withText: existingText)
            }
        }
        if let existingSelectedTextRange = self.selectedTextRange {
            self.selectedTextRange = nil
            self.selectedTextRange = existingSelectedTextRange
        }
    }
}

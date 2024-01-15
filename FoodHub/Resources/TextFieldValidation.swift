//
//  TextFieldValidation.swift
//  FoodHub
//
//  Created by Moataz Mohamed on 15/01/2024.
//

import Foundation

import UIKit

struct Validation{
    static func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    static func isPasswordValid(_ password: String) -> Bool {
        let passwordRegex = "^(?=.*[A-Z])(?=.*[a-z])(?=.*\\d)(?=.*[^a-zA-Z\\d]).{8,}$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordTest.evaluate(with: password)
    }
    
    enum AlertType {
        case invalidEmail
        case invalidPassword
        
        var title: String {
            switch self {
            case .invalidEmail:
                return "Invalid E-mail"
            case .invalidPassword:
                return "Invalid Password"
            }
        }
        
        var message: String {
            switch self {
            case .invalidEmail:
                return "The provided e-mail address is not valid."
            case .invalidPassword:
                return "Password must meet the following criteria:\n- At least 8 characters\n- At least 1 uppercase letter\n- At least 1 lowercase letter\n- At least 1 special character"
            }
        }
    }
    static func popAlert(alertType: AlertType)-> UIAlertController {
        let alert = UIAlertController(title: alertType.title, message: alertType.message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
                
        return alert
    }
    
    
}

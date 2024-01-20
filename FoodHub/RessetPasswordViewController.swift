//
//  RessetPasswordViewController.swift
//  FoodHub
//
//  Created by Moataz Mohamed on 21/01/2024.
//

import UIKit

class RessetPasswordViewController: UIViewController {

    
    //    MARK: - View Controller life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        setViewsHierarchy()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setUpConstraints()
    }

    
    //    MARK: - Views
    
    //    Design Components
    
    private let component1:UIImageView={
        let imageView=UIImageView().configureSharedViews(with: .dcircle1)
        return imageView
    }()
    
    private let component2:UIImageView={
        let imageView=UIImageView().configureSharedViews(with: .qcircle2)
        return imageView
    }()
    
    private let component3:UIImageView={
        let imageView=UIImageView().configureSharedViews(with: .scircle3)
        return imageView
        
    }()
    
    private let backButton:UIButton={
        let button=UIButton(type: .system)
        button.setImage(UIImage(named: "backButton")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.layer.shadowOpacity=0.1
        button.layer.shadowRadius=4
        button.layer.shadowOffset=CGSize(width: 0, height: 2)
        button.translatesAutoresizingMaskIntoConstraints=false
        return button
    }()
    
    private let titleLabel:UILabel={
        let label=UILabel()
        label.configure(with: .title, text: "Vefification Code")
        return label
    }()
    
    private let subTitle:UILabel={
        let label = UILabel()
        label.configure(with: .subTitle(font: 16), text: "Please type the verification code sent to\n prelookstudio@gmail.com")
        label.numberOfLines = 2
        return label
        
    }()

    private let emailTextField:UITextField={
        let field = UITextField()
        field.configure(with: .email)
        return field
    }()
    
    private let mainButton:UIButton={
        let button = UIButton.mainButton
        button.setTitle("Send new password", for: .normal)
        return button
    }()

    
    //    MARK: - Set Up Constraints
    
    private func setUpConstraints(){
        let component2Cons=[
            component2.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            component2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            component2.widthAnchor.constraint(equalToConstant: 80),
            component2.heightAnchor.constraint(equalToConstant: 80)
        ]
        NSLayoutConstraint.activate(component2Cons)
        
        let backButtonCons=[
            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 35),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            backButton.widthAnchor.constraint(equalToConstant: 100),
            backButton.heightAnchor.constraint(equalToConstant: 100)
        ]
        NSLayoutConstraint.activate(backButtonCons)
        
        let titleLabelCons=[
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height/4 - 30),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 26),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            titleLabel.heightAnchor.constraint(equalToConstant: 42)
        ]
        NSLayoutConstraint.activate(titleLabelCons)
        
        let subTitleLabelCons = [
            subTitle.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            subTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25)
        ]
        NSLayoutConstraint.activate(subTitleLabelCons)
        
        let emailTextFieldCons=[
            emailTextField.topAnchor.constraint(equalTo: subTitle.bottomAnchor, constant: 40),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 26),
            emailTextField.widthAnchor.constraint(equalToConstant: view.frame.width - 50 ),
            emailTextField.heightAnchor.constraint(equalToConstant: 55)
        ]
        NSLayoutConstraint.activate(emailTextFieldCons)
        
        let mainButtonCons=[
            mainButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainButton.widthAnchor.constraint(equalToConstant: 260),
            mainButton.heightAnchor.constraint(equalToConstant: 60),
            mainButton.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 50)
        ]
        NSLayoutConstraint.activate(mainButtonCons)
        
    }
    
    //    MARK: - Set Up UI

    private func setViewsHierarchy(){
        
        //  Design Components
        view.addSubview(component1)
        view.addSubview(component2)
        view.addSubview(component3)
        view.addSubview(backButton)
        view.addSubview(titleLabel)
        view.addSubview(subTitle)
        
        view.addSubview(emailTextField)
        view.addSubview(mainButton)
    }
    
    
}

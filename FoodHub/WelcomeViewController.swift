//
//  ViewController.swift
//  FoodHub
//
//  Created by Moataz Mohamed on 09/01/2024.
//

import UIKit
import RxSwift
import RxCocoa
class WelcomeViewController: UIViewController {
    
    private var gradientLayer:CAGradientLayer?
    private let viewModel=WelcomeViewModel()
    private let disposeBag = DisposeBag()

    
//    MARK: - View Controller life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewsHierarchy()
        tapStartButton()
        tapSignIn()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setUpConstraints()
    }
    
//    MARK: - Views
    
    private let backGroundImage:UIImageView={
        let image = UIImage(named: "welcomeImage")
        let imageView=UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints=false
        return imageView
        
    }()
    
    private let skipButton:UIButton={
        let button = UIButton(type: .system)
        button.setTitle("Skip", for: .normal)
        button.layer.cornerRadius=15
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(hex: k.orangeColor)
        button.translatesAutoresizingMaskIntoConstraints=false
        return button
    }()
    
//    Welcome Message View
    private let welcomeMessageView:UIView={
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let titleLabel:UILabel={
        let label = UILabel()
        label.text = "Welcome to"
        label.font = UIFont.boldSystemFont(ofSize: 45)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let subTitleLabel:UILabel={
        let label = UILabel()
        label.text = "FoodHub"
        label.font = UIFont.boldSystemFont(ofSize: 40)
        label.textColor = UIColor(hex: k.orangeColor)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let descriptionLabel:UILabel={
        let label = UILabel()
        label.text = "Your favourite foods delivered \n fast at your door."
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = UIColor(hex: 0x30384F)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
//    authentication view
    
    private let authView:UIView={
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    private let label:UILabel={
        let label = UILabel()
        label.text = "⎯⎯⎯⎯⎯⎯⎯    Sign in With    ⎯⎯⎯⎯⎯⎯⎯⎯"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let faceButton:UIButton={
        let button = UIButton().setButton(for: .facebook)
        return button
        
    }()
    private let googleButton:UIButton={
        let button = UIButton().setButton(for: .google)
        return button
        
    }()
    
    private let startButton :UIButton={
        let button = UIButton(type: .system)
        button.setTitle("Start with email or phone", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        button.setTitleColor(.white, for: .normal)
        button.layer.borderWidth=1
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 32
        button.backgroundColor = UIColor.white.withAlphaComponent(0.21)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let lastLabel:UILabel={
       let label = UILabel()
        label.text="Already have an account? "
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints=false
        return label
    }()
    private let signInButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedString = NSAttributedString(string: "Sign In", attributes: [
            NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue,
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15),
            NSAttributedString.Key.foregroundColor: UIColor.white,
            ])
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setAttributedTitle(attributedString, for: .normal)
        return button
    }()

    
    
//    MARK: - Set Up Constraints
    private func setUpConstraints(){
        navigationController?.navigationBar.isHidden=true
        backGroundImage.frame = view.bounds
        gradientLayer!.frame = view.bounds
        
        let skipButtonCons=[
            skipButton.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor , constant: 15),
            skipButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            skipButton.widthAnchor.constraint(equalToConstant: 55),
            skipButton.heightAnchor.constraint(equalToConstant: 32)
        ]
        NSLayoutConstraint.activate(skipButtonCons)
        
        //    Welcome Message View
        let welcomMessageViewCons = [
            welcomeMessageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 120),
            welcomeMessageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            welcomeMessageView.widthAnchor.constraint(equalToConstant: 300),
            welcomeMessageView.heightAnchor.constraint(equalToConstant: 180)
            
        ]
        NSLayoutConstraint.activate(welcomMessageViewCons)
        
        let titleLabelCons = [
            titleLabel.topAnchor.constraint(equalTo: welcomeMessageView.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: welcomeMessageView.leadingAnchor, constant: 10)
        ]
        NSLayoutConstraint.activate(titleLabelCons)
        
        let subTitleLabelCons = [
            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0),
            subTitleLabel.leadingAnchor.constraint(equalTo: welcomeMessageView.leadingAnchor, constant: 10)
        ]
        NSLayoutConstraint.activate(subTitleLabelCons)
        
        let descCons = [
            descriptionLabel.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: welcomeMessageView.leadingAnchor, constant: 10)
        ]
        NSLayoutConstraint.activate(descCons)
        
//        Authentication View
        let authViewCons = [
            authView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            authView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            authView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1),
            authView.heightAnchor.constraint(equalTo: view.heightAnchor,multiplier: 0.3),
        ]
        NSLayoutConstraint.activate(authViewCons)
        
        let signInLabelCons=[
            label.topAnchor.constraint(equalTo: authView.topAnchor, constant: 15),
            label.centerXAnchor.constraint(equalTo: authView.centerXAnchor)
            
        ]
        NSLayoutConstraint.activate(signInLabelCons)
        
        let faceButtonCons = [
            faceButton.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20),
            faceButton.leadingAnchor.constraint(equalTo: authView.leadingAnchor, constant: 15),
            faceButton.widthAnchor.constraint(equalTo: authView.widthAnchor, multiplier: 0.37),
            faceButton.heightAnchor.constraint(equalToConstant: 50)

        ]
        faceButton.layer.cornerRadius = faceButton.frame.height/2
        NSLayoutConstraint.activate(faceButtonCons)
        
        let googleButtonCons = [
            googleButton.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20),
            googleButton.trailingAnchor.constraint(equalTo: authView.trailingAnchor, constant: -15),
            googleButton.widthAnchor.constraint(equalTo: authView.widthAnchor, multiplier: 0.4), // Adjust the multiplier as needed
            googleButton.heightAnchor.constraint(equalToConstant: 50)
            
        ]
        googleButton.layer.cornerRadius = googleButton.frame.height/2
        NSLayoutConstraint.activate(googleButtonCons)
        
        let startButtonCons=[
            startButton.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 90),
            startButton.leadingAnchor.constraint(equalTo: authView.leadingAnchor, constant: 15),
            startButton.trailingAnchor.constraint(equalTo: authView.trailingAnchor, constant: -15),
            startButton.heightAnchor.constraint(equalToConstant: 65)
        ]
        NSLayoutConstraint.activate(startButtonCons)
        
        let lastLabelCons=[
            lastLabel.topAnchor.constraint(equalTo: startButton.bottomAnchor, constant: 20),
            lastLabel.leadingAnchor.constraint(equalTo: authView.leadingAnchor, constant: 70)
        ]
        NSLayoutConstraint.activate(lastLabelCons)
        
        let signInButtonCons=[
            signInButton.topAnchor.constraint(equalTo: startButton.bottomAnchor, constant: 15),
            signInButton.leadingAnchor.constraint(equalTo: lastLabel.trailingAnchor, constant: 3)
            
        ]
        NSLayoutConstraint.activate(signInButtonCons)
        




    }

    
//    MARK: - Set Up UI
    
    private func setViewsHierarchy(){
        // BackGround Image
        view.addSubview(backGroundImage)
        addGradiant()
        view.addSubview(skipButton)
//        Welcome Message View
        
        view.addSubview(welcomeMessageView)
        welcomeMessageView.addSubview(titleLabel)
        welcomeMessageView.addSubview(subTitleLabel)
        welcomeMessageView.addSubview(descriptionLabel)
        
//        Authentication View
        
        view.addSubview(authView)
        authView.addSubview(label)
        authView.addSubview(faceButton)
        authView.addSubview(googleButton)
        authView.addSubview(startButton)
        authView.addSubview(lastLabel)
        authView.addSubview(signInButton)

    }
    
    
//    MARK: - Private functions
    
    private func addGradiant(){
        let gradiant=CAGradientLayer()
        gradiant.colors=[
            UIColor.clear.cgColor,
            UIColor.black.cgColor
        ]
        view.layer.addSublayer(gradiant)
        self.gradientLayer = gradiant
        
    }
    
    
//    MARK: - Navigation
    func tapStartButton(){
        startButton.rx.tap
            .subscribe { [weak self] _  in
                self?.navigationController?.pushViewController(SignUpViewController(), animated: true)
            }.disposed(by: disposeBag)
    }
//    TODO: - Handle navigation(Just uncomment)
    func tapSignIn(){
        signInButton.rx.tap
            .subscribe { /*[weak self]*/ _ in
//                self?.navigationController?.pushViewController(LogInViewController(), animated: true)
            }.disposed(by: disposeBag)
    }
    
    
    
    


}


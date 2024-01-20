//
//  LogInViewController.swift
//  FoodHub
//
//  Created by Moataz Mohamed on 19/01/2024.
//

import UIKit
import RxSwift
import RxCocoa
class LogInViewController: UIViewController {
    
    
    private let disposeBag = DisposeBag()
    private let viewModel = LogInViewModel()
    private let tapGesture = UITapGestureRecognizer()
    
    private var isemailIsValidSubject = BehaviorRelay<Bool>(value: false)
    private var ispasswordIsValidSubject = BehaviorRelay<Bool>(value: false)
    
    
    //    MARK: - View Controller life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        
        setViewsHierarchy()
        bindToTapGesture()
        
        // Bind Text Fields
        bindToEmailTextField()
        bindToPasswordTextField()
        //Input Validation
        emailValidation()
        passwordValidation()
        
        //Main Button
        handleMainButtonBehavior()
        bindToMainButton()

//        Alert
        alertNetworkRespond()
        
//        Navigation
        signUpButtonPressed()
        forgotPwButtonPressed()

        subscribeToIndecator()
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
        label.configure(with: .title, text: "Login")
        return label
    }()
    
    //    E-mail View
    
    private let emailView:UIView={
        let view=UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints=false
        return view
    }()
    
    private let emailLabel:UILabel={
        let label=UILabel()
        label.configure(with: .subTitle(font: 16), text: "E-mail")
        return label
    }()
    
    private let emailTextField:UITextField={
        let field = UITextField()
        field.configure(with: .email)
        return field
    }()
    
    //    Password View
    
    private let passwordView:UIView={
        let view=UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints=false
        return view
    }()
    
    private let passwordLabel:UILabel={
        let label=UILabel()
        label.configure(with: .subTitle(font: 16), text: "Password")
        return label
    }()
    
    private let passwordTextField:UITextField={
        let field = UITextField()
        field.configure(with: .password(enableVisibilityToggle: true))
        return field
    }()
    
    private let forgotPwButton:UIButton={
        let button = UIButton(type: .system)
        button.setTitle("Forgot password?", for: .normal)
        button.setTitleColor(UIColor(hex: 0xFE724C), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.translatesAutoresizingMaskIntoConstraints=false
        return button
    }()
    
    //    Sign In View
    
    private let logInView:UIView={
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints=false
        return view
    }()
    
    private let mainButton:UIButton={
        let button = UIButton.mainButton
        button.setTitle("LogIn", for: .normal)
        return button
    }()
    
    private let subLabel:UILabel={
        let label = UILabel()
        label.configure(with: .subTitle(font: 14), text: "Don’t have an account?")
        label.textColor = .black
        return label
    }()
    
    private let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(UIColor(hex: k.orangeColor), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let label :UILabel={
        let label = UILabel()
        label.configure(with: .subTitle(font: 12),
                        text: "⎯⎯⎯⎯⎯⎯⎯⎯⎯    Sign In With    ⎯⎯⎯⎯⎯⎯⎯⎯⎯")
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
    
//    Activity Indecator
    
    private let indecator:UIActivityIndicatorView={
        let indecator = UIActivityIndicatorView()
        indecator.style = .large
        return indecator
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
        
        let titleLabelCons = [
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height/4 - 30),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 26),
            titleLabel.widthAnchor.constraint(equalToConstant: 129),
            titleLabel.heightAnchor.constraint(equalToConstant: 42)
        ]
        NSLayoutConstraint.activate(titleLabelCons)
        
        //    E-mail View
        
        let emailViewCons=[
            emailView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
            emailView.widthAnchor.constraint(equalToConstant: view.frame.width),
            emailView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.13)
        ]
        NSLayoutConstraint.activate(emailViewCons)
        
        let emailLabelCons=[
            emailLabel.topAnchor.constraint(equalTo: emailView.topAnchor, constant: 0),
            emailLabel.leadingAnchor.constraint(equalTo: emailView.leadingAnchor, constant: 28)
            
        ]
        NSLayoutConstraint.activate(emailLabelCons)
        
        let emailTextFieldCons=[
            emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 5),
            emailTextField.leadingAnchor.constraint(equalTo: emailView.leadingAnchor, constant: 26),
            emailTextField.widthAnchor.constraint(equalToConstant: view.frame.width - 50 ),
            emailTextField.heightAnchor.constraint(equalTo: emailView.heightAnchor, multiplier: 0.49)
        ]
        NSLayoutConstraint.activate(emailTextFieldCons)
        
        
        //        Password View
        
        let passwordViewCons=[
            passwordView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordView.topAnchor.constraint(equalTo: emailView.bottomAnchor, constant: 0),
            passwordView.widthAnchor.constraint(equalToConstant: view.frame.width),
            passwordView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.13)
        ]
        NSLayoutConstraint.activate(passwordViewCons)
        
        let passwordLabelCons=[
            passwordLabel.topAnchor.constraint(equalTo: passwordView.topAnchor, constant: 0),
            passwordLabel.leadingAnchor.constraint(equalTo: passwordView.leadingAnchor, constant: 28)
            
        ]
        NSLayoutConstraint.activate(passwordLabelCons)
        
        let passwordTextfieldCons=[
            passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 5),
            passwordTextField.leadingAnchor.constraint(equalTo: passwordView.leadingAnchor, constant: 26),
            passwordTextField.widthAnchor.constraint(equalToConstant: view.frame.width - 50 ),
            passwordTextField.heightAnchor.constraint(equalTo: passwordView.heightAnchor, multiplier: 0.49)
        ]
        NSLayoutConstraint.activate(passwordTextfieldCons)
        
        let forgotPwButtonCons=[
            forgotPwButton.topAnchor.constraint(equalTo: passwordView.bottomAnchor, constant: 3),
            forgotPwButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ]
        NSLayoutConstraint.activate(forgotPwButtonCons)
        
        //        Sign In View
        
        let logInViewCons=[
            logInView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            logInView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            logInView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            logInView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.35)
        ]
        NSLayoutConstraint.activate(logInViewCons)
        
        let mainButtonCons=[
            mainButton.centerXAnchor.constraint(equalTo: logInView.centerXAnchor),
            mainButton.widthAnchor.constraint(equalToConstant: 248),
            mainButton.heightAnchor.constraint(equalToConstant: 60),
            mainButton.topAnchor.constraint(equalTo: logInView.topAnchor, constant: 0)
        ]
        NSLayoutConstraint.activate(mainButtonCons)
        
        let subLabelCons=[
            subLabel.topAnchor.constraint(lessThanOrEqualTo: logInView.topAnchor, constant: 90),
            subLabel.centerXAnchor.constraint(equalTo: logInView.centerXAnchor, constant: -15)
        ]
        NSLayoutConstraint.activate(subLabelCons)
        
        let logInButtonCons=[
            signUpButton.topAnchor.constraint(lessThanOrEqualTo: logInView.topAnchor, constant: 84),
            signUpButton.leadingAnchor.constraint(equalTo: subLabel.trailingAnchor, constant: 3)
        ]
        NSLayoutConstraint.activate(logInButtonCons)
        
        let labelCons=[
            label.topAnchor.constraint(lessThanOrEqualTo: logInView.topAnchor, constant: 150),
            label.centerXAnchor.constraint(equalTo: logInView.centerXAnchor)
        ]
        NSLayoutConstraint.activate(labelCons)
        
        let faceButtonCons = [
            faceButton.topAnchor.constraint(lessThanOrEqualTo: logInView.topAnchor, constant: 175),
            faceButton.leadingAnchor.constraint(equalTo: logInView.leadingAnchor, constant: 15),
            faceButton.widthAnchor.constraint(equalToConstant: 150),
            faceButton.heightAnchor.constraint(equalToConstant: 50),
        ]
        faceButton.layer.cornerRadius = faceButton.frame.height/2
        NSLayoutConstraint.activate(faceButtonCons)
        
        let googleButtonCons = [
            googleButton.topAnchor.constraint(lessThanOrEqualTo: logInView.topAnchor, constant: 175),
            googleButton.trailingAnchor.constraint(equalTo: logInView.trailingAnchor, constant: -15),
            googleButton.widthAnchor.constraint(equalToConstant: 150),
            googleButton.heightAnchor.constraint(equalToConstant: 50),
        ]
        googleButton.layer.cornerRadius = googleButton.frame.height/2
        NSLayoutConstraint.activate(googleButtonCons)
        
//        Indecator
        indecator.center = view.center
        
        
    }
    
    
    //    MARK: - Set Up UI
    private func setViewsHierarchy(){
        //  Design Components
        view.addSubview(component1)
        view.addSubview(component2)
        view.addSubview(component3)
        view.addSubview(backButton)
        view.addSubview(titleLabel)
        
        // E-mail View
        view.addSubview(emailView)
        emailView.addSubview(emailLabel)
        emailView.addSubview(emailTextField)
        
        //password View
        
        view.addSubview(passwordView)
        passwordView.addSubview(passwordLabel)
        passwordView.addSubview(passwordTextField)
        
        view.addSubview(forgotPwButton)
        
        // Sign UP View
        view.addSubview(logInView)
        logInView.addSubview(mainButton)
        logInView.addSubview(subLabel)
        logInView.addSubview(signUpButton)
        logInView.addSubview(label)
        logInView.addSubview(faceButton)
        logInView.addSubview(googleButton)
        
        view.addGestureRecognizer(tapGesture)
        
//        Indecator
        view.addSubview(indecator)
        view.bringSubviewToFront(indecator)
    }
    
    
    //    MARK: - Binding and Behavior
    private func bindToTapGesture(){
        tapGesture.rx.event.observe(on: MainScheduler.instance)
            .bind { [weak self] _ in
                self?.view.endEditing(true)
            }.disposed(by: disposeBag)
        
    }
    
    private func bindToEmailTextField() {
        emailTextField.rx.controlEvent(.editingDidBegin)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext:  {[weak self] _ in
                guard let self = self else { return}
                self.handleTextFieldsBehavior(for: self.emailTextField)
            }).disposed(by: disposeBag)
        
        
        emailTextField.rx.controlEvent(.editingDidEnd)
            .do(onNext: {[weak self] _ in
                guard let self = self else { return}
                DispatchQueue.main.async {
                    self.resetTextFieldsBehavior(for: self.emailTextField)
                }
            })
            .map { [weak self] in self?.emailTextField.text ?? "" }
            .filter { !$0.isEmpty }
            .bind(to: viewModel.emailInputSubject)
            .disposed(by: disposeBag)
    }
    
    private func bindToPasswordTextField(){
        passwordTextField.rx.controlEvent(.editingDidBegin)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext:  {[weak self] _ in
                guard let self = self else { return}
                self.handleTextFieldsBehavior(for: self.passwordTextField)
            }).disposed(by: disposeBag)
        
        
        
        passwordTextField.rx.controlEvent(.editingDidEnd)
            .do(onNext: {[weak self] _ in
                guard let self = self else { return}
                DispatchQueue.main.async {
                    self.resetTextFieldsBehavior(for: self.passwordTextField)
                }
            })
            .map{[weak self] in self?.passwordTextField.text ?? ""}
            .filter{!$0.isEmpty}
            .bind(to: viewModel.passwordInputSubject)
            .disposed(by: disposeBag)
    }
    
    //    Main Button
    private func bindToMainButton(){
        mainButton.rx.tap.bind(to: viewModel.mainButtonSubject).disposed(by: disposeBag)
    }
    
    private func handleMainButtonBehavior(){
        Observable
            .combineLatest(isemailIsValidSubject, ispasswordIsValidSubject)
            .subscribe(onNext: { [weak self] (isEmailValid, isPasswordValid) in
                let isButtonEnabled = isEmailValid && isPasswordValid
                self?.mainButton.isEnabled = isButtonEnabled
            }).disposed(by: disposeBag)
    }
    
//    Indecator
    private func subscribeToIndecator(){
        viewModel.isAnimatingRelay.observe(on: MainScheduler.instance).subscribe {[weak self] isAnimate in
            if isAnimate{
                self?.indecator.startAnimating()
            }else{
                self?.indecator.stopAnimating()
            }
        }.disposed(by: disposeBag)
    }
    
    //    MARK: - Validation
    private func emailValidation() {
        viewModel.isvalidEmail()
            .observe(on: MainScheduler.instance)
            .subscribe {[weak self] isValid in
                self?.isemailIsValidSubject.accept(isValid)
                if !isValid {
                    self?.present(Validation.popAlert(alertType: .invalidEmail), animated: true)
                }
            }
            .disposed(by: disposeBag)
    }
    
    private func passwordValidation() {
        viewModel.isValidPassword()
            .observe(on: MainScheduler.instance)
            .subscribe {[weak self] isValid in
                self?.ispasswordIsValidSubject.accept(isValid)
                if !isValid {
                    self?.present(Validation.popAlert(alertType: .invalidPassword), animated: true)
                }
            }
            .disposed(by: disposeBag)
    }
    

    
//    MARK: - Navigation
    private func signUpButtonPressed(){
        signUpButton.rx.tap
            .subscribe { [weak self] _ in
                self?.navigationController?.pushViewController(SignUpViewController(), animated: true)
            }.disposed(by: disposeBag)
    }
    
    private func forgotPwButtonPressed(){
//        forgotPwButton.rx.tap
//            .subscribe { [weak self] _ in
//                self?.navigationController?.pushViewController(ForgotPasswordViewController(), animated: true)
//            }.disposed(by: disposeBag)
    }
        
//    MARK: - private functions
    
    
    private func alertNetworkRespond(){
        
        viewModel.requestError.observe(on: MainScheduler.instance).subscribe(onNext: {[weak self] error in
            guard let self = self else {return}
            self.present(self.requestAlert(title: "Error", message: error.localizedDescription), animated: true)
        }).disposed(by: disposeBag)
        
        viewModel.result.observe(on: MainScheduler.instance).subscribe {[weak self] result in
            guard let self = self else {return}
            self.present(self.requestAlert(title: result.element!.status, message: result.element!.message), animated: true)
        }.disposed(by: disposeBag)
    }
    
    private func requestAlert(title:String , message:String)-> UIAlertController{
        let alert = UIAlertController(title:title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        return alert
    }
    
    private func handleTextFieldsBehavior(for textField:UITextField){
        textField.borderStyle = .none
        textField.layer.borderWidth=1
        textField.layer.borderColor = UIColor(hex: k.orangeColor).cgColor
    }
    
    private func resetTextFieldsBehavior(for textField:UITextField){
        textField.borderStyle = .roundedRect
        textField.layer.borderWidth=0
        textField.layer.borderColor = nil
        
    }
}

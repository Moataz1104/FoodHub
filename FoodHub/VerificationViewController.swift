//
//  VerificationViewController.swift
//  FoodHub
//
//  Created by Moataz Mohamed on 20/01/2024.
//

import UIKit
import OTPFieldView
import RxSwift
import RxCocoa

class VerificationViewController:UIViewController{
    private let viewModel = VerificationViewModel()
    private let disposeBag = DisposeBag()
    
    
    
    //    MARK: - View Controller life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden=true
        otpView.delegate = self
        setViewsHierarchy()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setUpConstraints()
        subscribeToResultSubject()
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
    
//    OTP View
    private lazy var otpView:OTPFieldView={
        let viewOtp = OTPFieldView()
        viewOtp.fieldsCount=6
        viewOtp.fieldBorderWidth = 2
        viewOtp.defaultBorderColor = UIColor.lightGray
        viewOtp.filledBorderColor = UIColor(hex: k.orangeColor)
        viewOtp.cursorColor = UIColor(hex: k.orangeColor)
        viewOtp.fieldFont = UIFont.systemFont(ofSize: 23)
        viewOtp.displayType = .roundedCorner
        
        viewOtp.fieldSize = view.frame.width * 0.135
        viewOtp.separatorSpace = 10

        viewOtp.shouldAllowIntermediateEditing = false
        viewOtp.translatesAutoresizingMaskIntoConstraints=false
        return viewOtp
    }()

    
    private let resendLabel:UILabel={
       let label=UILabel()
        label.configure(with: .subTitle(font: 17), text: "I didn't recevie a code!")
        label.textColor = .black
        return label
    }()
    
    private let resendButton:UIButton={
        let button=UIButton(type: .system)
        button.setTitle("Please resend", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        button.setTitleColor(UIColor(hex: k.orangeColor), for: .normal)
        
        button.translatesAutoresizingMaskIntoConstraints=false
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
        
        //        OTP View
        let otpViewCons = [
            otpView.topAnchor.constraint(equalTo: subTitle.bottomAnchor, constant: 40),
            otpView.widthAnchor.constraint(equalToConstant: view.frame.width),
            otpView.heightAnchor.constraint(equalToConstant: 80)
        ]
        
        NSLayoutConstraint.activate(otpViewCons)
        otpView.initializeUI()
        
        let resendLabelCons=[
            resendLabel.topAnchor.constraint(equalTo: otpView.bottomAnchor, constant: 20),

            resendLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50)
        ]
        NSLayoutConstraint.activate(resendLabelCons)
        
        let resendButtonCons=[
            resendButton.topAnchor.constraint(equalTo: otpView.bottomAnchor, constant: 15),
            resendButton.leadingAnchor.constraint(equalTo: resendLabel.trailingAnchor, constant: 3)
        ]
        NSLayoutConstraint.activate(resendButtonCons)
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
        
        // OTP View
        view.addSubview(otpView)
        view.addSubview(resendLabel)
        view.addSubview(resendButton)


    }
    
    
//    MARK: - Subscribtion
    
    private func subscribeToResultSubject(){
        viewModel.resultSubject.observe(on: MainScheduler.instance)
            .subscribe {[weak self] event in
                guard let self = self else {return}
                switch event.element!{
                case .success(let result):
                    print(result)
                case .failure(let errorMessage):
                    self.present(requestAlert(title: "Error", message: errorMessage), animated: true)
                }
            }.disposed(by: disposeBag)
        
    }
//    MARK: - Navigation

    
    
 //    MARK: - private functions

    private func requestAlert(title:String , message:String)-> UIAlertController{
        let alert = UIAlertController(title:title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        return alert
    }

    
}


//    MARK: -  OTPField View Delegate

extension VerificationViewController: OTPFieldViewDelegate {
    func shouldBecomeFirstResponderForOTP(otpTextFieldIndex index: Int) -> Bool {
        true
    }
    
    func enteredOTP(otp: String) {
        viewModel.otpRelay.accept(otp)
    }
    
    func hasEnteredAllOTP(hasEnteredAll: Bool) -> Bool {
        return true
    }
    
    
}

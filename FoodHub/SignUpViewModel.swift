//
//  SignUpViewModel.swift
//  FoodHub
//
//  Created by Moataz Mohamed on 15/01/2024.
//

import Foundation
import RxSwift
import RxCocoa

class SignUpViewModel {
    private let disposeBag = DisposeBag()
    
    let userNameInputSubject = PublishSubject<String>()
    let emailInputSubject = PublishSubject<String>()
    let passwordInputSubject = PublishSubject<String>()


    func isvalidEmail() -> Observable<Bool> {
        return emailInputSubject
            .map { Validation.isValidEmail($0) }
    }
    
    func isValidPassword()-> Observable<Bool>{
        return passwordInputSubject
            .map{Validation.isPasswordValid($0)}
    }
    


}

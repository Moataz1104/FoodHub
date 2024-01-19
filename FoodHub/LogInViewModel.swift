//
//  LogInViewModel.swift
//  FoodHub
//
//  Created by Moataz Mohamed on 19/01/2024.
//

import Foundation
import RxSwift
import RxCocoa

class LogInViewModel{
    private let disposeBag = DisposeBag()

    
    let emailInputSubject = PublishRelay<String>()
    let passwordInputSubject = PublishRelay<String>()
    let mainButtonSubject = PublishRelay<Void>()
    var result = PublishRelay<RegisterModel>()
    var requestError=PublishRelay<Error>()
    
    
    func isvalidEmail() -> Observable<Bool> {
        return emailInputSubject
            .map { Validation.isValidEmail($0) }
    }
    
    func isValidPassword()-> Observable<Bool>{
        return passwordInputSubject
            .map{Validation.isPasswordValid($0)}
    }
    
}

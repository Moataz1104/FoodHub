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
    
    let userNameInputSubject = PublishRelay<String>()
    let emailInputSubject = PublishRelay<String>()
    let passwordInputSubject = PublishRelay<String>()
    let mainButtonSubject = PublishRelay<Void>()
    let result = PublishRelay<RegisterModel>()
    let requestError=PublishRelay<Error>()
    let isAnimatingRelay = PublishRelay<Bool>()

    
    func isvalidEmail() -> Observable<Bool> {
        return emailInputSubject
            .map { Validation.isValidEmail($0) }
    }
    
    func isValidPassword()-> Observable<Bool>{
        return passwordInputSubject
            .map{Validation.isPasswordValid($0)}
    }
    
    

    
    
    private func combineLatestInputs() -> Observable<(String, String, String)> {
        return Observable.combineLatest(userNameInputSubject, emailInputSubject, passwordInputSubject)
    }

    
    
    private func sendRequest(){
        mainButtonSubject
            .withLatestFrom(combineLatestInputs())
            .flatMapLatest {[weak self] (username, email, password) in
                print("Main button tapped with latest values:", username, email, password)
                self?.isAnimatingRelay.accept(true)
                return ApiCaller.shared.registerUser(username: username, email: email, password: password)
                    .asObservable()
                    .catch {[weak self] error in
                        print("Network error: \(error)")
                        self?.requestError.accept(error)
                        self?.isAnimatingRelay.accept(false)
                        return Observable.empty()
                    }
            }
            .subscribe(onNext: {[weak self] result in
                print("Network request successful:", result)
                self?.isAnimatingRelay.accept(false)
                self?.result.accept(result)
            })
            .disposed(by: disposeBag)

    }
    
    
    init() {
        sendRequest()
    }





}

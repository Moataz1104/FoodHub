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
    let result = PublishRelay<LogInModel>()
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
    
    
    private func combineLatestInputs() -> Observable<(String, String)> {
        return Observable.combineLatest(emailInputSubject, passwordInputSubject)
    }
    
    
    
    private func sendRequest(){
        mainButtonSubject
            .withLatestFrom(combineLatestInputs())
            .flatMapLatest {[weak self] (email, password) in
                self?.isAnimatingRelay.accept(true)
                print("Main button tapped with latest values:", email, password)
                return ApiCaller.shared.logInUser(email: email, password: password)
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
                self?.isAnimatingRelay.accept(true)
                self?.result.accept(result)
            })
            .disposed(by: disposeBag)
        
    }
    
    init() {
        sendRequest()
    }

    
}

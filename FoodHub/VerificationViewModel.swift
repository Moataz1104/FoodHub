//
//  VerificationViewModel.swift
//  FoodHub
//
//  Created by Moataz Mohamed on 20/01/2024.
//

import RxSwift
import RxCocoa

class VerificationViewModel{
    private let disposeBag=DisposeBag()
    
    enum ResultType {
        case success(VerificationModel)
        case failure(String)
    }
    
    let otpRelay = PublishRelay<String>()
    let resultSubject = PublishSubject<ResultType>()

    private func sendRequest(){
        otpRelay
            .flatMapLatest{ otp in
                return ApiCaller.shared.verifyUserOtp(otp: otp)
                    .asObservable()
                    .materialize()
            }.subscribe {[weak self] event in
                switch event{
                case .next(let result):
                    self?.resultSubject.onNext(.success(result))
                case .error(_):
                    self?.resultSubject.onNext(.failure("Verification failed"))
                case .completed:
                    break
                    
                }
            }.disposed(by: disposeBag)
    }
    
    init(){
        sendRequest()
    }
}

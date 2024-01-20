//
//  ApiCaller.swift
//  FoodHub
//
//  Created by Moataz Mohamed on 15/01/2024.
//

//Moataz@222
import Foundation
import RxSwift
import RxCocoa

class ApiCaller {
    
    static let shared = ApiCaller()
    
    private init() {}
    
    private let baseUrl = URL(string: "https://0766-102-190-250-116.ngrok-free.app/api/Authentication")!
    
    
    
    
    
//    MARK: - User Login
    func logInUser(email: String, password: String) -> Observable<LogInModel> {
        let body: [String: Any] = [
            "email": email,
            "password": password,
        ]
        return buildRequest(method: "POST", pathComponent: "/login", body: body)
            .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
            .map { data in
                try! JSONDecoder().decode(LogInModel.self, from: data)
            }.observe(on: ConcurrentDispatchQueueScheduler(qos: .background))
    }
    
//    MARK: - User Registeration
    func registerUser(username: String, email: String, password: String) -> Observable<RegisterModel> {
        let body: [String: Any] = [
            "username": username,
            "email": email,
            "password": password,
            "phoneNumber": "00000000000",
            "roles": ["User"]
        ]
        return buildRequest(method: "POST", pathComponent: "/register", body: body)
            .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
            .map { data in
                try! JSONDecoder().decode(RegisterModel.self, from: data)
            }.observe(on: ConcurrentDispatchQueueScheduler(qos: .background))
    }
    
    //    MARK: - Verify OTP
    func verifyUserOtp(otp:String) -> Observable<VerificationModel> {
            let body: [String: Any] = [
                "otp":otp
            ]
            return buildRequest(method: "POST", pathComponent: "/otp", body: body)
                .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
                .map { data in
                    try! JSONDecoder().decode(VerificationModel.self, from: data)
                }.observe(on: ConcurrentDispatchQueueScheduler(qos: .background))
        }
    
    
//    MARK: - Bulding request
    private func buildRequest(method: String, pathComponent: String, body: [String: Any]?) -> Observable<Data> {
        let url = baseUrl.appendingPathComponent(pathComponent)
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        if method == "GET" {
            // Handle GET request
        } else {
            let jsonData = try! JSONSerialization.data(withJSONObject: body!, options: .prettyPrinted)
            request.httpBody = jsonData
            
        }
        
        request.url = url
        request.httpMethod = method
        
        let session = URLSession.shared
        
        return session.rx.data(request: request)
    }
}

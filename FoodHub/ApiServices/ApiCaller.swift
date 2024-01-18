//
//  ApiCaller.swift
//  FoodHub
//
//  Created by Moataz Mohamed on 15/01/2024.
//

import Foundation
import RxSwift
import RxCocoa

class ApiCaller {
    
    static let shared = ApiCaller()
    
    private init() {}
    
    private let baseUrl = URL(string: "https://5856-197-134-125-52.ngrok-free.app/api/Authentication")!
    
    
    
    
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

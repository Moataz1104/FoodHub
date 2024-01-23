//
//  MenuViewModel.swift
//  FoodHub
//
//  Created by Moataz Mohamed on 23/01/2024.
//

import Foundation
import RxSwift
import RxCocoa

class MenuViewModel{
    
    let items:Observable<[cellDataStruct]>
    
    struct cellDataStruct{
        let title:String
        let imageName:String
    }
    
    init() {
        let cellsData: [cellDataStruct] = [
            cellDataStruct(title: "My Orders", imageName: "line.3.horizontal.decrease.circle.fill"),
            cellDataStruct(title: "My Profile", imageName: "person.fill"),
            cellDataStruct(title: "Delivery Address", imageName: "Location"),
            cellDataStruct(title: "Payment Methods", imageName: "wallet"),
            cellDataStruct(title: "Contact Us", imageName: "envelope.badge.fill"),
            cellDataStruct(title: "Settings", imageName: "gearshape.fill"),
            cellDataStruct(title: "Helps & FAQs", imageName: "questionmark.app.fill"),

        ]
        items = Observable.just(cellsData)
    }
}

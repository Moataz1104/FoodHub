//
//  UIView+Extensions.swift
//  FoodHub
//
//  Created by Moataz Mohamed on 13/01/2024.
//

import UIKit

extension UIView{
    enum SharedViewType{
        case dcircle1
        case qcircle2
        case scircle3
    }
    
    func configureSharedViews(with type:SharedViewType) -> UIImageView{
        var image:UIImage?
        
        switch type{
        case .dcircle1:
            image=UIImage(named: "donaCircle")?.withRenderingMode(.alwaysOriginal)
        case .qcircle2:
            image=UIImage(named: "Qcircle")?.withRenderingMode(.alwaysOriginal)
        case .scircle3:
            image=UIImage(named: "semiCircle")?.withRenderingMode(.alwaysOriginal)
        }
        let imageView=UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints=false
        return imageView
    }
    
}
//static var quarterCircle:UIImageView={
//    let image=UIImage(named: "Qcircle")?.withRenderingMode(.alwaysOriginal)
//    let imageView=UIImageView(image: image)
//    imageView.translatesAutoresizingMaskIntoConstraints=false
//    return imageView
//}()

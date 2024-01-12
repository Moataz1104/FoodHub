//
//  SharedViews.swift
//  FoodHub
//
//  Created by Moataz Mohamed on 12/01/2024.
//

import UIKit

class SharedViews{
    
    static var quarterCircle:UIImageView={
        let image=UIImage(named: "Qcircle")?.withRenderingMode(.alwaysOriginal)
        let imageView=UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints=false
        return imageView
    }()
    static var donaCircle:UIImageView={
        let image=UIImage(named: "donaCircle")?.withRenderingMode(.alwaysOriginal)
        let imageView=UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints=false
        return imageView
        
    }()
    static var semiCircle:UIImageView={
        let image=UIImage(named: "semiCircle")?.withRenderingMode(.alwaysOriginal)
        let imageView=UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints=false
        return imageView
    }()
    
}

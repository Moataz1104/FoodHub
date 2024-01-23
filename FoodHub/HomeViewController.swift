//
//  HomeViewController.swift
//  FoodHub
//
//  Created by Moataz Mohamed on 22/01/2024.
//

import UIKit
import SideMenu
class HomeViewController: UIViewController {
    
    var menu: SideMenuNavigationController?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        menu = SideMenuNavigationController(rootViewController: MenuViewController())
        menu?.presentationStyle = .menuSlideIn
        menu?.menuWidth = view.frame.width * 0.65
        menu?.leftSide = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Menu", style: .done, target: self, action: #selector(menuButtonTapped))

        view.backgroundColor = .lightGray
    }
    
    @objc func menuButtonTapped() {
        // Present the side menu when the button is tapped
        present(menu!, animated: true, completion: nil)
    }
}

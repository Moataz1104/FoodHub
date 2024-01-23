//
//  MenuViewController.swift
//  FoodHub
//
//  Created by Moataz Mohamed on 22/01/2024.
//

import UIKit
import RxSwift
import RxCocoa

class MenuViewController: UIViewController {

    let viewModel = MenuViewModel()
    let disposeBag = DisposeBag()

    
//    MARK: - View Controller life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setViewsHierarchy()
        tableViewBinding()
        selectedCells()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setUpConstraints()
    }
    
//    MARK: - Views
    
//    Main View
    private let mainView:UIView={
        let view = UIView()
        view.backgroundColor = UIColor(hex: k.orangeColor)
        view.layer.cornerRadius = 40
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let userImage:UIImageView={
        let image = UIImage(named: "photo")
        let imageView=UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true

        imageView.layer.cornerRadius = 50
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private let titleLabel:UILabel={
        let label = UILabel()
        label.text = "Moataz Mohamed"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let tableView:UITableView={
        let tableView=UITableView()
        tableView.backgroundColor = .clear
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let logOutButton:UIButton={
        let button = UIButton()
        button.setImage(UIImage(named: "logOut")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.backgroundColor = UIColor(hex: k.orangeColor)
        button.setTitle(" Log Out", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.layer.cornerRadius = 21.5
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    
//    MARK: - Set Up Constraints
    private func setUpConstraints(){
        let mainViewCons=[
            mainView.topAnchor.constraint(equalTo: view.topAnchor, constant: -40),
            mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -40),
            mainView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3),
            mainView.widthAnchor.constraint(equalToConstant: view.frame.width + 40)
        ]
        NSLayoutConstraint.activate(mainViewCons)
        
        let userImageCons=[
            userImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -40),
            userImage.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
            userImage.widthAnchor.constraint(equalToConstant: 100),
            userImage.heightAnchor.constraint(equalToConstant: 100)

        ]
        NSLayoutConstraint.activate(userImageCons)
        
        let titleLabelCons=[
            titleLabel.topAnchor.constraint(equalTo: userImage.bottomAnchor, constant: 5),
            titleLabel.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
            
            
        ]
        NSLayoutConstraint.activate(titleLabelCons)
        
        let tableViewCons=[
            tableView.topAnchor.constraint(equalTo: mainView.bottomAnchor, constant: 20),
            tableView.widthAnchor.constraint(equalTo: view.widthAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -200)
        ]
        NSLayoutConstraint.activate(tableViewCons)
        
        let logOutButtonCons=[
            logOutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            logOutButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60),
            logOutButton.widthAnchor.constraint(equalToConstant: 117),
            logOutButton.heightAnchor.constraint(equalToConstant: 43)
        ]
        NSLayoutConstraint.activate(logOutButtonCons)

        
    }
    
//    MARK: - Set Up UI

    private func setViewsHierarchy(){
        view.addSubview(mainView)
        mainView.addSubview(userImage)
        mainView.addSubview(titleLabel)
        view.addSubview(tableView)
        view.addSubview(logOutButton)
    }
    
    
//    MARK: - Table View configuration
    
    private func tableViewBinding(){
        viewModel.items
            .bind(to:tableView.rx.items(cellIdentifier: "Cell")){_ , element,cell in
                cell.textLabel?.text = element.title
                if let image = UIImage(systemName: element.imageName)?.withTintColor(UIColor(hex: 0x9796A1), renderingMode: .alwaysOriginal) {
                    cell.imageView?.image = image
                }else{
                    cell.imageView?.image = UIImage(named: element.imageName)
                }
            }.disposed(by: disposeBag)
    }
    
    private func selectedCells(){
        tableView.rx.itemSelected
            .subscribe {[weak self] indexPath in
                self?.tableView.deselectRow(at: indexPath, animated: true)
            }.disposed(by: disposeBag)
    }
    

}

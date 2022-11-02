//
//  BaseViewController.swift
//  Week18Assignments
//
//  Created by Doy Kim on 2022/11/03.
//

import UIKit


import UIKit

class BaseViewController: UIViewController {
    let networkManager = NetworkManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground
        configure()
        setNavigationBar()
        checkNetworkAvailability()

    }
    func configure() { }
    func setNavigationBar() {
        self.navigationController?.navigationBar.tintColor = .black
    }
    func checkNetworkAvailability() {
        networkManager.isUnreachable { _ in
            print("인터넷 연결이 안됩니다 ")
        }
    }
}

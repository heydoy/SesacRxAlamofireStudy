//
//  BaseViewController.swift
//  Week18Assignments
//
//  Created by Doy Kim on 2022/11/03.
//

import UIKit
import Hero

class BaseViewController: UIViewController {
    let networkManager = NetworkManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground
        configure()
        setNavigationBar()

    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        checkNetworkAvailability()

    }
    func configure() { }
    func setNavigationBar() {
        self.navigationController?.navigationBar.tintColor = .black
    }
    func checkNetworkAvailability() {
        networkManager.isUnreachable { [weak self] _ in
            print("인터넷 연결이 안됩니다.")
            let vc = OfflineWarningViewController()
            vc.hero.isEnabled = true
            vc.hero.modalAnimationType = .slide(direction: .up)
            vc.modalPresentationStyle = .fullScreen
            
            self?.present(vc, animated: true, completion: nil)
        }
    }
}

//
//  LoginViewController.swift
//  Week18Assignments
//
//  Created by Doy Kim on 2022/11/03.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: BaseViewController {
    
    let mainView = LoginView()
    let disposeBag = DisposeBag()
    let viewModel = LoginViewModel()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.backgroundColor = .orange
        
        bind()
    }
    
    func bind () {
        
        mainView.loginButton
            .rx.tap
            .withUnretained(self)
            .bind { (vc, _) in
                vc.viewModel.postLogin(email: "hue@hue.com", password: "hue12345")
                print(UserDefaults.token)
                
                
            }
            .disposed(by: disposeBag)
        
        mainView.goSignupButton
            .rx.tap
            .bind { [weak self] _ in
                let vc = SignupViewController()
                vc.modalPresentationStyle = .fullScreen
                
                self?.present(vc, animated: true, completion: nil)
            }
            .disposed(by: disposeBag)
    }
    


}

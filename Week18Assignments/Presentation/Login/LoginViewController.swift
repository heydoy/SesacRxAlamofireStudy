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
        
        let emailValidation = mainView.emailTextField
            .rx.text
            .orEmpty
            .map { $0.isValidEmail() }
            .share()
        
        emailValidation.bind(to: mainView.emailValidationLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        let passwordValidation = mainView.passwordTextField
            .rx.text
            .orEmpty
            .map { $0.isValidPassword() }
            .share()
        
        passwordValidation
            .bind(to: mainView.loginButton.rx.isEnabled, mainView.passwordValidationLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        mainView.loginButton
            .rx.tap
            .withUnretained(self)
            .bind { (vc, _) in
                vc.viewModel.postLogin(
                    email: vc.mainView.emailTextField.text!,
                    password: vc.mainView.passwordTextField.text!)
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

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
        
        let input = LoginViewModel.Input(
            emailText: mainView.emailTextField
            .rx.text,
            passwordText: mainView.passwordTextField
            .rx.text,
            loginTap: mainView.loginButton
                .rx.tap,
            goSignupTap: mainView.goSignupButton
                .rx.tap)
        let output = viewModel.transform(input: input)
        
        output.emailValidation
            .bind(to: mainView.emailValidationLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        output.passwordValidation
            .bind(to: mainView.loginButton.rx.isEnabled, mainView.passwordValidationLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        output.loginTap
            .withUnretained(self)
            .bind { (vc, _) in
                vc.viewModel.postLogin(
                    email: vc.mainView.emailTextField.text!,
                    password: vc.mainView.passwordTextField.text!)
                print(UserDefaults.token)
            }
            .disposed(by: disposeBag)
        
        output.goSignupTap
            .bind { [weak self] _ in
                let vc = SignupViewController()
                vc.modalPresentationStyle = .fullScreen
                
                self?.present(vc, animated: true, completion: nil)
            }
            .disposed(by: disposeBag)
    }
    


}

//
//  SignupViewController.swift
//  Week18Assignments
//
//  Created by Doy Kim on 2022/11/03.
//

import UIKit
import RxSwift
import RxCocoa

class SignupViewController: BaseViewController {
    
    let mainView = SignupView()
    let disposeBag = DisposeBag()
    let viewModel = SignupViewModel()
    
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.backgroundColor = .green
        
        bind()
    }
    
    func bind() {
        
        let input = SignupViewModel.Input(
            nicknameText:  mainView.nicknameTextField
                .rx.text,
            emailText: mainView.emailTextField
                .rx.text,
            passwordText: mainView.passwordTextField
                .rx.text,
            registerTap: mainView.registerButton
                .rx.tap
        )
        
        let output = viewModel.transform(input: input)
       
        output.nicknameText
            .orEmpty
            .bind { [weak self] value in
                if value.isValidString(.nicknameRegex) {
                    self?.viewModel.signupInfo.nickname = value
                }
            }
            .disposed(by: disposeBag)

        
        output.nicknameValidation
            .bind(to:  mainView.nicknameValidationLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        output.nicknameValidation
            .map { !$0 }
            .bind(to:
                mainView.emailTextField.rx.isHidden,
                mainView.emailValidationLabel.rx.isHidden
            )
            .disposed(by: disposeBag)
        
        
        output.validNicknameAsDriver
            .drive(mainView.nicknameValidationLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.emailText
            .orEmpty
            .bind { [weak self] value in
                if value.isValidString(.emailRegex) {
                    self?.viewModel.signupInfo.email = value
                }
            }
            .disposed(by: disposeBag)
        
        
        output.emailValidation
            .bind(to: mainView.emailValidationLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        output.emailValidation
            .map { !$0 }
            .bind(to: mainView.passwordTextField.rx.isHidden, mainView.passwordValidationLabel.rx.isHidden)
            .disposed(by: disposeBag)
       
        output.validEmailAsDriver
            .drive(mainView.emailValidationLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.passwordText.orEmpty
            .bind { [weak self] value in
                if value.isValidString(.passwordRegex) {
                    self?.viewModel.signupInfo.password = value
                }
            }
            .disposed(by: disposeBag)
        
        output.passwordValidation
            .bind(to: mainView.passwordValidationLabel.rx.isHidden, mainView.registerButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        output.passwordValidation
            .withUnretained(self)
            .bind { (vc, value) in
                vc.mainView.registerButton.backgroundColor = value ? .systemPink : .lightGray
            }
            .disposed(by: disposeBag)
        
        output.validPasswordAsDriver
            .drive(mainView.passwordValidationLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.registerTap
            .withUnretained(self)
            .subscribe {(vc, _ ) in
                vc.viewModel.postSignup(
                    userName: vc.viewModel.signupInfo.nickname,
                    email: vc.viewModel.signupInfo.email,
                    password: vc.viewModel.signupInfo.password)
                print(vc.viewModel.signupInfo, vc.viewModel.signupResponse)
            }
            .disposed(by: disposeBag)
        
        output.signupResponseAsDriver
            .drive(onNext: { [weak self] _ in
                let vc = LoginViewController()
                self?.present(vc, animated: true)
            })
            .disposed(by: disposeBag)
    }
    
}

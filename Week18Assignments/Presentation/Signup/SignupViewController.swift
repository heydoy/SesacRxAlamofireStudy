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
        mainView.nicknameTextField
            .rx.text.orEmpty
            .bind { [weak self] value in
                if value.isValidString(.nicknameRegex) {
                    self?.viewModel.signupInfo.nickname = value
                }
            }
            .disposed(by: disposeBag)

        let nicknameValidation = mainView.nicknameTextField
            .rx
            .text
            .orEmpty
            .map { $0.isValidString(.nicknameRegex) }
            .share()
        
        nicknameValidation
            .bind(to:  mainView.nicknameValidationLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        nicknameValidation
            .map { !$0 }
            .bind(to:
                mainView.emailTextField.rx.isHidden,
                mainView.emailValidationLabel.rx.isHidden
            )
            .disposed(by: disposeBag)
        
        viewModel.validNicknameText
            .asDriver(onErrorJustReturn: "")
            .drive(mainView.nicknameValidationLabel.rx.text)
            .disposed(by: disposeBag)
        
        mainView.emailTextField
            .rx.text.orEmpty
            .bind { [weak self] value in
                if value.isValidString(.emailRegex) {
                    self?.viewModel.signupInfo.email = value
                }
            }
            .disposed(by: disposeBag)
        
        let emailValidation = mainView.emailTextField
            .rx
            .text
            .orEmpty
            .map { $0.isValidString(.emailRegex) }
            .share()
        
        emailValidation
            .bind(to: mainView.emailValidationLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        emailValidation
            .map { !$0 }
            .bind(to: mainView.passwordTextField.rx.isHidden, mainView.passwordValidationLabel.rx.isHidden)
            .disposed(by: disposeBag)
       
        viewModel.validEmailText
            .asDriver(onErrorJustReturn: "")
            .drive(mainView.emailValidationLabel.rx.text)
            .disposed(by: disposeBag)
        
        mainView.passwordTextField
            .rx.text.orEmpty
            .bind { [weak self] value in
                if value.isValidString(.passwordRegex) {
                    self?.viewModel.signupInfo.password = value
                }
            }
            .disposed(by: disposeBag)
        
        let passwordValidation = mainView.passwordTextField
            .rx
            .text
            .orEmpty
            .map { $0.isValidString(.passwordRegex) }
            .share()
        
        passwordValidation
            .bind(to: mainView.passwordValidationLabel.rx.isHidden, mainView.registerButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        passwordValidation
            .withUnretained(self)
            .bind { (vc, value) in
                vc.mainView.registerButton.backgroundColor = value ? .systemPink : .lightGray
            }
            .disposed(by: disposeBag)
        
        viewModel.validPasswordText
            .asDriver(onErrorJustReturn: "")
            .drive(mainView.passwordValidationLabel.rx.text)
            .disposed(by: disposeBag)
        
        mainView.registerButton
            .rx
            .tap
            .withUnretained(self)
            .subscribe {(vc, _ ) in
                vc.viewModel.postSignup(
                    userName: vc.viewModel.signupInfo.nickname,
                    email: vc.viewModel.signupInfo.email,
                    password: vc.viewModel.signupInfo.password)
                print(vc.viewModel.signupInfo, vc.viewModel.signupResponse)
            }
            .disposed(by: disposeBag)
        
        viewModel.signupResponse
            .asDriver(onErrorJustReturn: false)
            .drive(onNext: { [weak self] _ in
                let vc = LoginViewController()
                self?.present(vc, animated: true)
            })
            .disposed(by: disposeBag)
    }
    
}

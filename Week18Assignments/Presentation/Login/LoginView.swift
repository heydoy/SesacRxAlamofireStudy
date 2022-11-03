//
//  LoginView.swift
//  Week18Assignments
//
//  Created by Doy Kim on 2022/11/03.
//

import UIKit
import SnapKit
import Then

final class LoginView: BaseView {
    let emailTextField = UITextField().then {
        $0.placeholder = "이메일을 입력해주세요."
        $0.clearButtonMode = .whileEditing
        $0.font = .systemFont(ofSize: 14)
        $0.layer.cornerRadius = 8
        $0.backgroundColor = .white
        $0.autocapitalizationType = .none
    }
    let emailValidationLabel = UILabel().then {
        $0.text = "유효한 이메일을 입력해주세요."
        $0.font = .systemFont(ofSize: 12)
        $0.textColor = .darkGray
    }
    let passwordTextField = UITextField().then {
        $0.placeholder = "비밀번호를 입력해주세요"
        $0.font = .systemFont(ofSize: 14)
        $0.clearButtonMode = .whileEditing
        $0.isSecureTextEntry = true
        $0.layer.cornerRadius = 8
        $0.backgroundColor = .white
        $0.autocapitalizationType = .none
    }
    let passwordValidationLabel = UILabel().then {
        $0.text = "유효한 비밀번호를 입력해주세요."
        $0.font = .systemFont(ofSize: 12)
        $0.textColor = .darkGray
    }
    let loginButton = UIButton().then {
        $0.setTitle("로그인", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 12
        $0.clipsToBounds = true
        $0.backgroundColor = .darkGray
    }
    let goSignupButton = UIButton().then {
        $0.setTitle("회원가입", for: .normal)
        $0.setTitleColor(.darkGray, for: .normal)
        $0.backgroundColor = .clear
    }
    
    override func setupUI() {
        addSubviews(
            emailTextField, emailValidationLabel,
            passwordTextField, passwordValidationLabel,
            loginButton, goSignupButton
        )
    }
    
    override func setConstraints() {
        emailTextField.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(20)
            make.centerY.equalToSuperview().multipliedBy(0.6)
            make.height.equalTo(50)
        }
        emailValidationLabel.snp.makeConstraints { make in
            make.leading.equalTo(emailTextField)
            make.top.equalTo(emailTextField.snp.bottom).offset(6)
        }
        passwordTextField.snp.makeConstraints { make in
            make.horizontalEdges.height.equalTo(emailTextField)
            make.top.equalTo(emailValidationLabel.snp.bottom).offset(12)
        }
        passwordValidationLabel.snp.makeConstraints { make in
            make.leading.equalTo(passwordTextField)
            make.top.equalTo(passwordTextField.snp.bottom).offset(6)
        }
        
        loginButton.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(emailTextField)
            make.top.equalTo(passwordValidationLabel.snp.bottom).offset(6)
            make.height.equalTo(70)
        }
        
        goSignupButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(44)
            make.bottom.equalTo(safeAreaLayoutGuide).inset(12)
        }
    }

}

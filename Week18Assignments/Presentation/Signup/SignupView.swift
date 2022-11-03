//
//  SignupView.swift
//  Week18Assignments
//
//  Created by Doy Kim on 2022/11/03.
//

import UIKit
import SnapKit
import Then

class SignupView: BaseView {
    let nicknameTextField = UITextField().then {
        $0.placeholder = "닉네임을 입력해주세요"
        $0.clearButtonMode = .whileEditing
        $0.font = .systemFont(ofSize: 14)
        $0.layer.cornerRadius = 8
        $0.backgroundColor = .white
        $0.autocapitalizationType = .none
    }
    let nicknameValidationLabel = UILabel().then {
        $0.text = "유효한 닉네임을 입력해주세요."
        $0.font = .systemFont(ofSize: 12)
        $0.textColor = .darkGray
    }
    let emailTextField = UITextField().then {
        $0.placeholder = "이메일을 입력해주세요."
        $0.clearButtonMode = .whileEditing
        $0.font = .systemFont(ofSize: 14)
        $0.layer.cornerRadius = 8
        $0.backgroundColor = .white
        $0.isHidden = true
        $0.autocapitalizationType = .none
    }
    let emailValidationLabel = UILabel().then {
        $0.text = "유효한 이메일을 입력해주세요."
        $0.font = .systemFont(ofSize: 12)
        $0.textColor = .darkGray
        $0.isHidden = true
    }
    let passwordTextField = UITextField().then {
        $0.placeholder = "비밀번호를 입력해주세요"
        $0.font = .systemFont(ofSize: 14)
        $0.clearButtonMode = .whileEditing
        $0.isSecureTextEntry = true
        $0.layer.cornerRadius = 8
        $0.backgroundColor = .white
        $0.isHidden = true
        $0.autocapitalizationType = .none
    }
    let passwordValidationLabel = UILabel().then {
        $0.text = "유효한 비밀번호를 입력해주세요."
        $0.font = .systemFont(ofSize: 12)
        $0.textColor = .darkGray
        $0.isHidden = true
    }
    let registerButton = UIButton().then {
        $0.setTitle("회원가입", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 12
        $0.clipsToBounds = true
        $0.backgroundColor = .darkGray
    }
    
    override func setupUI() {
        self.backgroundColor = .orange
        
        addSubviews(
            nicknameTextField, nicknameValidationLabel,
            emailTextField, emailValidationLabel,
            passwordTextField, passwordValidationLabel,
            registerButton
        )
    }
    
    override func setConstraints() {
        nicknameTextField.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(20)
            make.top.equalTo(safeAreaLayoutGuide).inset(40)
            make.height.equalTo(60)
        }
        nicknameValidationLabel.snp.makeConstraints { make in
            make.leading.equalTo(nicknameTextField)
            make.top.equalTo(nicknameTextField.snp.bottom).offset(6)
        }
        emailTextField.snp.makeConstraints { make in
            make.horizontalEdges.height.equalTo(nicknameTextField)
            make.top.equalTo(nicknameValidationLabel.snp.bottom).offset(12)
        }
        emailValidationLabel.snp.makeConstraints { make in
            make.leading.equalTo(emailTextField)
            make.top.equalTo(emailTextField.snp.bottom).offset(6)
        }
        passwordTextField.snp.makeConstraints { make in
            make.horizontalEdges.height.equalTo(nicknameTextField)
            make.top.equalTo(emailValidationLabel.snp.bottom).offset(12)
        }
        passwordValidationLabel.snp.makeConstraints { make in
            make.leading.equalTo(passwordTextField)
            make.top.equalTo(passwordTextField.snp.bottom).offset(6)
        }
        
        registerButton.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(nicknameTextField)
            make.bottom.equalTo(safeAreaLayoutGuide).inset(6)
            make.height.equalTo(70)
        }
    }

}

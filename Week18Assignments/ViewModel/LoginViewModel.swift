//
//  LoginViewModel.swift
//  Week18Assignments
//
//  Created by Doy Kim on 2022/11/03.
//

import Foundation
import RxSwift
import RxCocoa

class LoginViewModel: CommonViewModelType {
    
    let loginResponse = PublishSubject<Bool>()
    
    func postLogin(email: String, password: String) {
        let api = SeSACAPI.login(email: email, password: password)
        
        SeSACNetwork.shared.requestSeSAC(ofType: Login.self, url: api.url, method: .post, parameters: api.parameters, headers: api.headers) { [weak self] response in
            switch response {
            case .success(let success):
                UserDefaults.token = success.token
                self?.loginResponse.onNext(true)
            case .failure(let failure):
                self?.loginResponse.onError(failure)
            }
        }
    }
    struct Input {
        let emailText: ControlProperty<String?>
        let passwordText: ControlProperty<String?>
        let loginTap: ControlEvent<Void>
        let goSignupTap: ControlEvent<Void>
    }
    struct Output {
        let emailValidation: Observable<Bool>
        let passwordValidation:
            Observable<Bool>
        let loginTap: ControlEvent<Void>
        let goSignupTap: ControlEvent<Void>
    }
    
    func transform(input: Input) -> Output {
        let emailValidation = input.emailText
            .orEmpty
            .map { $0.isValidString(.emailRegex) }
            .share()
        let passwordValidation = input.passwordText
            .orEmpty
            .map { $0.isValidString(.passwordRegex) }
            .share()
        
        
        return Output(
            emailValidation: emailValidation,
            passwordValidation: passwordValidation,
            loginTap: input.loginTap,
            goSignupTap: input.goSignupTap)
        
    }
}

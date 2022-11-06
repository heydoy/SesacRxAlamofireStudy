//
//  SignupViewModel.swift
//  Week18Assignments
//
//  Created by Doy Kim on 2022/11/03.
//

import Foundation
import RxSwift
import RxCocoa

class SignupViewModel: CommonViewModelType {
   
    var signupInfo = Signup(nickname: String(), email: String(), password: String())
    
    let validNicknameText = BehaviorRelay(value: "닉네임은 2자 이상 10자 이하의 한영, 숫자로 적어주세요.")
    let validEmailText = BehaviorRelay(value: "이메일 양식을 지켜주세요")
    let validPasswordText = BehaviorRelay(value: "비밀번호는 8글자 이상, 영어소문자와 숫자 둘 다 포함되어야 합니다.")
    
    let signupResponse = PublishSubject<Bool>()
    
    func postSignup(userName: String, email: String, password: String) {
        let api = SeSACAPI.signup(userName: userName, email: email, password: password)
        
        SeSACNetwork.shared.requestSeSAC(ofType: String.self, url: api.url, method: .post, parameters: api.parameters, headers: api.headers) { [weak self] response in
            switch response {
            case .success(_) :
                self?.signupResponse.onNext(true)
            case .failure(let failure):
                self?.signupResponse.onError(failure)
            }
        }
        
    }
    
    
    struct Input {
        let nicknameText:  ControlProperty<String?>
        let emailText: ControlProperty<String?>
        let passwordText: ControlProperty<String?>
        let registerTap: ControlEvent<Void>
    }
    
    struct Output {
        let nicknameText:  ControlProperty<String?>
        let nicknameValidation: Observable<Bool>
        let validNicknameAsDriver: Driver<String>
        
        let emailText: ControlProperty<String?>
        let emailValidation: Observable<Bool>
        let validEmailAsDriver:  Driver<String>
        
        let passwordText: ControlProperty<String?>
        let passwordValidation: Observable<Bool>
        let validPasswordAsDriver: Driver<String>
        
        let registerTap: ControlEvent<Void>
        
        let signupResponseAsDriver: Driver<Bool>
    }
    
    func transform(input: Input) -> Output {
        
        let nicknameValidation = input.nicknameText
            .orEmpty
            .map { $0.isValidString(.nicknameRegex) }
            .share()
        
        let validNicknameAsDriver = validNicknameText.asDriver(onErrorJustReturn: "")
        
        let emailValidation = input.emailText
            .orEmpty
            .map { $0.isValidString(.emailRegex) }
            .share()
        
        let validEmailAsDriver = validEmailText
            .asDriver(onErrorJustReturn: "")
        
        let passwordValidation = input.passwordText
            .orEmpty
            .map { $0.isValidString(.passwordRegex) }
            .share()
        
        let validPasswordAsDriver = validPasswordText.asDriver(onErrorJustReturn: "")
        
        let signupResponseAsDriver = signupResponse
            .asDriver(onErrorJustReturn: false)
        
        return Output(nicknameText: input.nicknameText, nicknameValidation: nicknameValidation, validNicknameAsDriver: validNicknameAsDriver, emailText: input.emailText,
            emailValidation: emailValidation,
            validEmailAsDriver: validEmailAsDriver,
            passwordText: input.passwordText,
            passwordValidation: passwordValidation,
            validPasswordAsDriver: validPasswordAsDriver,
            registerTap: input.registerTap,
            signupResponseAsDriver: signupResponseAsDriver)
    }
}

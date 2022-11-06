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
    
    let validEmailText = BehaviorRelay(value: "이메일 양식을 지켜주세요")
    let validNicknameText = BehaviorRelay(value: "닉네임은 2자 이상 10자 이하의 한영, 숫자로 적어주세요.")
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
        
    }
    
    struct Output {
        
    }
    
    func transform(input: Input) -> Output {
        
        return Output()
    }
}

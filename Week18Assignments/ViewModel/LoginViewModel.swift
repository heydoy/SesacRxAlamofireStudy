//
//  LoginViewModel.swift
//  Week18Assignments
//
//  Created by Doy Kim on 2022/11/03.
//

import Foundation
import RxSwift

class LoginViewModel {
    
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
}

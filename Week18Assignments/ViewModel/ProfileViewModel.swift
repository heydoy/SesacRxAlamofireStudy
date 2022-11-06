//
//  ProfileViewModel.swift
//  Week18Assignments
//
//  Created by Doy Kim on 2022/11/03.
//

import Foundation
import RxSwift
import RxCocoa

class ProfileViewModel: CommonViewModelType {
    
    let profile = PublishSubject<Profile>()
    
    func getProfile() {
        let api = SeSACAPI.profile
        SeSACNetwork.shared.requestSeSAC(ofType: Profile.self, url: api.url, method: .get, headers: api.headers) { [weak self] response in
            switch response {
            case .success(let success) :
                self?.profile.onNext(success)
            case .failure(let failure):
                self?.profile.onError(failure)
            }
        }
    }
    
    struct Input {
        
        // 로그아웃버튼 탭
        let logoutTap: ControlEvent<Void>
    }
    
    struct Output {
        // 로그아웃버튼 탭
        let logoutTap: ControlEvent<Void>
    }
    
    func transform(input: Input) -> Output {
        
        return Output(logoutTap: input.logoutTap)
    }
}

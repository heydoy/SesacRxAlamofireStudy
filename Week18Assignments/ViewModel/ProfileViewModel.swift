//
//  ProfileViewModel.swift
//  Week18Assignments
//
//  Created by Doy Kim on 2022/11/03.
//

import Foundation
import RxSwift

class ProfileViewModel {
    
    let profile = PublishSubject<Profile>()
    
    func getProfile() {
        let api = SeSACAPI.profile
        SeSACNetwork.shared.reqeustSeSAC(ofType: Profile.self, url: api.url, method: .get, headers: api.headers) { [weak self] response in
            switch response {
            case .success(let success) :
                self?.profile.onNext(success)
            case .failure(let failure):
                self?.profile.onError(failure)
            }
        }
    }
}

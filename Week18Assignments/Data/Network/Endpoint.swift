//
//  Endpoint.swift
//  Week18Assignments
//
//  Created by Doy Kim on 2022/11/03.
//

import Foundation
import Alamofire

enum SeSACAPI {
    static let BaseURL: String = "http://api.memolease.com/api/v1/users/"
    
    // 이렇게 값을 받아서 사용할 수 있음
    case signup(userName: String, email: String, password: String)
    case login(email: String, password: String)
    case profile
}

extension SeSACAPI {
    
    var url: URL {
        switch self {
        case .signup:
            return URL(string: SeSACAPI.BaseURL + "signup")!
        case .login:
            return URL(string: SeSACAPI.BaseURL + "login")!
        case .profile:
            return URL(string: SeSACAPI.BaseURL + "me")!
        }
    }
    
    var headers: HTTPHeaders {
        switch self {
        case .signup, .login:
            return [
                "Content-Type" : "application/x-www-form-urlencoded"
            ]
        case .profile:
            return [
                "Content-Type" : "application/x-www-form-urlencoded",
                "Authorization" : "Bearer \(UserDefaults.token)"
            ]
        }
    }
    
    var parameters: [String:String] {
        switch self {
        // 문제는? 파라미터를 사용자에게 입력받을 경우 어떻게 해결할 수 있을까
        // case에서 받아버리기
        case .signup(let username, let email, let password):
            return [
                "userName" : username,
                "email": email,
                "password": password
            ]
        case .login(let email, let password):
            return [
                "email": email,
                "password": password
               ]
            
        default:
            return [:]
        }
    }
}


enum MemoleaseURL: String {
    static let base = "http://api.memolease.com/api/v1/users/"
    
    case signup = "signup"
    case login = "login"
    case profile = "me"
    
    func getURL() -> String {
        return MemoleaseURL.base + self.rawValue
    }
}

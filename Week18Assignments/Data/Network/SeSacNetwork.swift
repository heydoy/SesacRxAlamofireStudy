//
//  SeSacNetwork.swift
//  Week18Assignments
//
//  Created by Doy Kim on 2022/11/03.
//

import Foundation
import Alamofire

enum SeSACError: Int, Error {
    case invalidAuthorization = 401
    case takenEmail = 406
    case emptyParameters = 501
}

extension SeSACError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidAuthorization:
            return "토큰이 만료되었습니다.다시 로그인해주세요."
        case .takenEmail:
            return "이미 가입된 회원입니다. 로그인해주세요."
        case .emptyParameters:
            return "파라미터가 없습니다."
        }
    }
}


final class SeSACNetwork {
    private init() {}
    
    static let shared = SeSACNetwork()
    
    /// 공통으로 요청하는 메서드
    /// ResponseString에 대응해서 바꿔줄 수도 있다.
    func reqeustSeSAC <T:Decodable> (ofType: T.Type = T.self, url: URL, method: HTTPMethod, parameters: [String:String]? = nil, headers: HTTPHeaders, completion: @escaping (Result<T, Error>) -> Void ) {
        
        AF.request(url, method: method, parameters: parameters, headers: headers).responseDecodable(of: ofType) { response in
            
            //completion(response.result)
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(_):
                guard let statusCode = response.response?.statusCode else { return } // 서버에서 스테이터스코드가 안 올 수 없어서 early exit을 했지만 진짜 문제가 생길경우 메시지를 보여주어야 할 것
                guard let error = SeSACError(rawValue: statusCode) else { return }
                completion(.failure(error))
            }
        }
    }
    
}

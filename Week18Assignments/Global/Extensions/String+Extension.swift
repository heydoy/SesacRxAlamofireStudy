//
//  String+Extension.swift
//  Week18Assignments
//
//  Created by Doy Kim on 2022/11/03.
//

import Foundation

enum StringPolicy: String {
    case nicknameRegex = #"^[가-힣a-zA-Z0-9]{2,10}$"# // 한글, 알파벳, 숫자 포함 2~10글자
    case emailRegex = #"^[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])$"# // 이메일 유효한지 정규식으로 체크
    case passwordRegex = #"^(?=.*\d)(?=.*[a-z])(?=.*[a-zA-Z]).{8,}$"# // 8글자 이상, 영어소문자, 숫자 반드시 포함
}

extension String {
    /// 닉네임 유효한지 정규식으로 체크
    /// 한글, 알파벳, 숫자 포함 2~10글자
    func isValidString(_ policy: StringPolicy) -> Bool {
        let regex = policy.rawValue
        let test = NSPredicate(format: "SELF MATCHES %@", regex)
        return test.evaluate(with: self)
    }
    
}


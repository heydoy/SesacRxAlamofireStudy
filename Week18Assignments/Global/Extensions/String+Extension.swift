//
//  String+Extension.swift
//  Week18Assignments
//
//  Created by Doy Kim on 2022/11/03.
//

import Foundation

extension String {
    /// 닉네임 유효한지 정규식으로 체크
    /// 한글, 알파벳, 숫자 포함 2~10글자
    func isValidNickname() -> Bool {
        let nicknameRegex = #"^[가-힣a-zA-Z0-9]{2,10}$"#
        let nicknameTest = NSPredicate(format: "SELF MATCHES %@", nicknameRegex)
        return nicknameTest.evaluate(with: self)
    }
    
    /// 이메일 유효한지 정규식으로 체크
    func isValidEmail() -> Bool {
        let emailRegex = #"^[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])$"#
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        
        return emailTest.evaluate(with: self)
    }
    
    /// 비밀번호 유효한지 정규식으로 체크
    /// 8글자 이상, 영어소문자, 숫자 반드시 포함
    func isValidPassword() -> Bool {
        let passwordRegex = #"^(?=.*\d)(?=.*[a-z])(?=.*[a-zA-Z]).{8,}$"#
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        
        return passwordTest.evaluate(with: self)
    }
}


//
//  Token.swift
//  Week18Assignments
//
//  Created by Doy Kim on 2022/11/03.
//

import Foundation

@propertyWrapper
struct UserDefault<Value> {
    let key: String
    let defaultValue: Value
    var container: UserDefaults = .standard

    var wrappedValue: Value {
        get {
            return container.object(forKey: key) as? Value ?? defaultValue
        }
        set {
            container.set(newValue, forKey: key)
        }
    }
}

extension UserDefaults {
    @UserDefault(key: "token", defaultValue: "")
    static var token: String
}

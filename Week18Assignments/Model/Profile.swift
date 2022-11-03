//
//  Profile.swift
//  Week18Assignments
//
//  Created by Doy Kim on 2022/11/03.
//

import Foundation

struct Profile: Codable {
    let user: User
}
struct User: Codable {
    let photo: String
    //let followers: follow
    //let following: follow
    //let _id: String
    let username: String
    let email: String
    //let __v: Int // 안쓰고 싶은 내용들은 생략을 해도 됨
    //let id: String
}

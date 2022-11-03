//
//  CommonViewModelType.swift
//  Week18Assignments
//
//  Created by Doy Kim on 2022/11/03.
//

import Foundation

protocol CommonViewModelType: AnyObject {
    associatedtype Input
    associatedtype Output
    func transform(input: Input) -> Output
} 

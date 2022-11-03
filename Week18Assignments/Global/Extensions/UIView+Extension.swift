//
//  UIView+Extension.swift
//  Week18Assignments
//
//  Created by Doy Kim on 2022/11/03.
//

import Foundation
import UIKit

extension UIView {
    /// Add multiple views at once to the end of the receiver’s list of subviews.
    /// 여러개의 뷰를 서브뷰로 한번에 추가합니다.
    func addSubviews(_ views: UIView...) {
        views.forEach { self.addSubview($0) }
    }
}

extension UIStackView {
    /// Add multiple views at once to the end of the arrangedSubview array
    /// 여러개의 뷰를 스택뷰에 한번에 추가합니다.
    func addArangedSubviews(_ views: UIView...) {
        for view in views { addArrangedSubview(view) }
    }
}

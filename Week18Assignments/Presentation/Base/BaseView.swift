//
//  BaseView.swift
//  Week18Assignments
//
//  Created by Doy Kim on 2022/11/03.
//

import UIKit

class BaseView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemBackground
        
        setupUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setupUI() {
        
    }
    
    func setConstraints() {}

}
Footer
© 2022 GitHub, Inc.
Footer navigation
Terms

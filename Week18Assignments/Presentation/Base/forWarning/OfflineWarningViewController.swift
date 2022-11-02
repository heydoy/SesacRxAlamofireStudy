//
//  OfflineWarningViewController.swift
//  Week18Assignments
//
//  Created by Doy Kim on 2022/11/03.
//

import UIKit
import SnapKit
import Then

final class OfflineWarningViewController: UIViewController {
    
    private let warningImageView = UIImageView().then {
        $0.image = UIImage(systemName: "wifi.slash")
        $0.tintColor = .systemGray4
        $0.contentMode = .scaleAspectFit
    }
    private let warningLabel = UILabel().then {
        $0.text = "네트워크에 연결할 수 없습니다."
        $0.font = .systemFont(ofSize: 14)
        $0.tintColor = .systemGray4
        $0.textAlignment = .center
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        setConstraint()
    }
    
    func configure() {
        view.addSubview(warningImageView)
        view.addSubview(warningLabel)
        
        view.backgroundColor = .systemBackground
    }
    
    func setConstraint() {
        warningImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().multipliedBy(0.78)
            make.width.equalToSuperview().multipliedBy(0.5)
            make.height.equalTo(warningImageView.snp.width)
        }
        warningLabel.snp.makeConstraints { make in
            make.centerX.equalTo(warningImageView)
            make.leading.trailing.greaterThanOrEqualToSuperview().inset(20)
            make.top.equalTo(warningImageView.snp.bottom).offset(12)
        }
    }
    
    

}

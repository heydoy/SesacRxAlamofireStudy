//
//  ProfileView.swift
//  Week18Assignments
//
//  Created by Doy Kim on 2022/11/03.
//

import UIKit
import SnapKit
import Then

final class ProfileView: BaseView {
    lazy var photoImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.layer.cornerRadius = $0.layer.bounds.width / 2
    }
    let usernameLabel = UILabel().then {
        $0.textAlignment = .center
        $0.font = .boldSystemFont(ofSize: 30)
    }
    let emailLabel = UILabel().then {
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 18)
    }
    let logoutButton = UIButton().then {
        $0.setTitle("로그아웃", for: .normal)
        $0.setTitleColor(.darkGray, for: .normal)
    }
    
    override func setupUI() {
        addSubviews( photoImageView, usernameLabel, emailLabel, logoutButton )
    }
    
    override func setConstraints() {
        photoImageView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).inset(20)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.4)
            make.height.equalTo(photoImageView.snp.width)
        }
        usernameLabel.snp.makeConstraints { make in
            make.centerX.equalTo(photoImageView)
            make.top.equalTo(photoImageView.snp.bottom).offset(10)
            make.horizontalEdges.greaterThanOrEqualToSuperview().inset(20)
        }
        emailLabel.snp.makeConstraints { make in
            make.centerX.equalTo(usernameLabel)
            make.top.equalTo(usernameLabel.snp.bottom).offset(6)
            make.horizontalEdges.greaterThanOrEqualToSuperview().inset(20)
        }
        
        logoutButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(safeAreaLayoutGuide).inset(20)
        }
    }
}

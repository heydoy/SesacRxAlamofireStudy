//
//  ProfileViewController.swift
//  Week18Assignments
//
//  Created by Doy Kim on 2022/11/03.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

class ProfileViewController: BaseViewController {
    
    let mainView = ProfileView()
    
    let viewModel = ProfileViewModel()
    let disposeBag = DisposeBag()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    func bind() {
        viewModel.profile
            .withUnretained(self)
            .subscribe { (vc, profile) in
                vc.mainView.emailLabel.text = profile.user.email
                vc.mainView.usernameLabel.text = profile.user.username
                let url = URL(string: profile.user.photo)!
                vc.mainView.photoImageView.kf.setImage(with: url, placeholder: UIImage(systemName: "photo.on.rectangle.angled"))
            } onError: { error in
                print(error.localizedDescription)
            } onDisposed: {
                print("disposed")
            }
            .disposed(by: disposeBag)

        viewModel.getProfile()
        
        mainView.logoutButton
            .rx.tap
            .withUnretained(self)
            .bind { (vc, _) in
                UserDefaults.token = ""
                vc.mainView.window!.rootViewController?.dismiss(animated: true, completion: nil)
            }
            .disposed(by: disposeBag)
    }
    

}

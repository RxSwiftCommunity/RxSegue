//
//  ProfileViewController.swift
//  RxSegue
//
//  Created by Segii Shulga on 1/11/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ProfileViewModel {
    let name:Variable<String>
    let email:Variable<String>
    let avatar:Variable<UIImage?>
    
    init(name:String, email:String, avatar:UIImage? = nil) {
        self.name = Variable(name)
        self.email = Variable(email)
        self.avatar = Variable(avatar)
    }
}

class ProfileViewController: BaseViewController {
    
    let disposeBag = DisposeBag()
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var emailLabel: UILabel!
    
    var profileViewModel:ProfileViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileViewModel.avatar
            .asObservable()
            .bindTo(imageView.rx.image)
            .addDisposableTo(disposeBag)
        
        profileViewModel.email
            .asObservable()
            .map(Optional.init)
            .bindTo(emailLabel.rx.text)
            .addDisposableTo(disposeBag)
        
        profileViewModel.name
            .asObservable()
            .map(Optional.init)
            .bindTo(nameLabel.rx.text)
            .addDisposableTo(disposeBag)
    }

}

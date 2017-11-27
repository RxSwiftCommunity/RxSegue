//
//  ViewController.swift
//  RxSegue
//
//  Created by sshulga on 01/11/2016.
//  Copyright (c) 2016 sshulga. All rights reserved.
//

import UIKit
import RxSegue
import RxSwift
import RxCocoa

struct StoryBoard {
    static let main = UIStoryboard(name: "Main", bundle: nil)
}

extension UIViewController {
    class var storyboardId: String {
        return String(describing: self)
    }
}

extension UIStoryboard {
    func instantiateViewController<T: UIViewController>() -> T {
        guard let viewController = instantiateViewController(withIdentifier: T.storyboardId) as? T else {
            fatalError("Cast error to \(T.self)")
        }
        return viewController
    }
}

class ViewController: BaseViewController {
    let disposeBag = DisposeBag()
    @IBOutlet var pushButton: UIButton!
    @IBOutlet var presentButton: UIButton!
    @IBOutlet weak var dismissButton: UIButton!
    
    var voidSegue: AnyObserver<Void> {
        return ModalSegue(fromViewController: self,
            toViewControllerFactory: { (sender, context) -> SecondViewController in
                return StoryBoard.main.instantiateViewController()
        }).asObserver()
    }
    
    var profileSegue: AnyObserver<ProfileViewModel> {
        return NavigationSegue(fromViewController: self.navigationController!,
            toViewControllerFactory: { (sender, context) -> ProfileViewController in
                let profileViewController: ProfileViewController = StoryBoard.main
                    .instantiateViewController()
                profileViewController.profileViewModel = context
                
                return profileViewController
        }).asObserver()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presentButton.rx.tap
            .bind(to: voidSegue)
            .disposed(by: disposeBag)
        
        pushButton.rx.tap
            .map {
                return ProfileViewModel(name: "John Doe",
                    email: "JohnDoe@example.com",
                    avatar: UIImage(named: "avatar"))
            }
            .bind(to: profileSegue)
            .disposed(by: disposeBag)
        
        dismissButton.rx.tap
            .subscribe (onNext: { [weak self] in
                self?.dismiss(animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
    }

}


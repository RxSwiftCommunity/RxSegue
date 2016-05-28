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
        return String(self)
    }
}

extension UIStoryboard {
    func instantiateViewController<T: UIViewController>() -> T {
        guard let viewController = instantiateViewControllerWithIdentifier(T.storyboardId) as? T else {
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
    
        presentButton.rx_tap
            .bindTo(voidSegue)
            .addDisposableTo(disposeBag)
        
        pushButton.rx_tap
            .map {
                return ProfileViewModel(name: "John Doe",
                    email: "JohnDoe@example.com",
                    avatar: UIImage(named: "avatar"))
            }
            .bindTo(profileSegue)
            .addDisposableTo(disposeBag)
        
        dismissButton.rx_tap
            .subscribeNext { [weak self] in
                self?.dismissViewControllerAnimated(true, completion: nil)
            }
            .addDisposableTo(disposeBag)
    }

}


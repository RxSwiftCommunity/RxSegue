//
//  SecondViewController.swift
//  RxSegue
//
//  Created by Segii Shulga on 1/11/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class SecondViewController: BaseViewController {

    let disposeBag = DisposeBag()
    
    @IBOutlet weak var dismissButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        dismissButton
            .rx.tap
            .subscribe(onNext:{ [weak self] in
                self?.dismiss(animated: true, completion: nil)
            })
            .addDisposableTo(disposeBag)
    }


}

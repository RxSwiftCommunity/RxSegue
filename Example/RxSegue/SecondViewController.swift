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
            .rx_tap
            .subscribeNext({ [weak self] in
                self?.dismissViewControllerAnimated(true, completion: nil)
            })
            .addDisposableTo(disposeBag)
    }


}

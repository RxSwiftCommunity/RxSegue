//
//  MockViewController.swift
//  RxSegue
//
//  Created by Segii Shulga on 3/19/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit

class MockViewController: UIViewController {
    
    override func present(_ viewControllerToPresent: UIViewController,
        animated flag: Bool,
        completion: (() -> Void)?) {
        completion?()
    }

}

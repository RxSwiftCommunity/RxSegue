//
//  BaseViewController.swift
//  RxSegue
//
//  Created by Segii Shulga on 3/19/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit
import RxSwift

//func delay(delay:Double, queue:dispatch_queue_t = dispatch_get_main_queue() , closure:()->()) {
//    dispatch_after(
//        dispatch_time(
//            DISPATCH_TIME_NOW,
//            Int64(delay * Double(NSEC_PER_SEC))
//        ),
//        queue, closure)
//}

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        #if TRACE_RESOURCES
            print("Number of start resources = \(RxSwift.Resources.total)")
        #endif
    }
    
    deinit {
        #if TRACE_RESOURCES
            print("deinit \(self)")
            print("View controller disposed with \(RxSwift.Resources.total) resources")
//            delay(0.1, closure: { () -> () in
//                print("Number of resource after deinit \(RxSwift.resourceCount)")
//            })
        #endif
    }

}

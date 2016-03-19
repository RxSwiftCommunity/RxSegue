//
//  SegueType.swift
//  Pods
//
//  Created by Segii Shulga on 3/19/16.
//
//

import UIKit
import RxSwift

public protocol SegueType: ObserverType {
    typealias T
    typealias U
    
    var fromViewController: T? { get }
    var toViewControllerFactory: (sender: T, context: E) -> U { get }
    var animated: Bool { get }
}

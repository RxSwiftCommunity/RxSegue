//
//  SegueType.swift
//  Pods
//
//  Created by Segii Shulga on 3/19/16.
//
//

import UIKit
import RxSwift

/**
 *  `SegueType`.
 
 represents base intarface for navigation abstraction
 */
public protocol SegueType: ObserverType {
   /**
    Type of the view controller from which navigation will appear
    */
    associatedtype T
   /**
    Type of the target view controller
    */
    associatedtype U
   /**
    Represents view controller from which navigation will appear
    */
    var fromViewController: T? { get }
   /**
    View controller factory closure, which produces view controller to navigate to
    
    - parameter sender:  view controller from which navigation will appear
    - parameter context: contex to pass to the target view controller
    
    - returns: created and configured view controller
    */
    var toViewControllerFactory: (_ sender: T, _ context: E) -> U { get }
   /**
    Represetns whether transitions should be animated or not
    */
    var animated: Bool { get }
}

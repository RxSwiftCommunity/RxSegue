//
//  NavigationSegue.swift
//  Pods
//
//  Created by Segii Shulga on 3/19/16.
//
//

import UIKit
import RxSwift

public struct NavigationSegue<
    FromViewControllerType: UINavigationController,
    ToViewControllerType: UIViewController,
    ContextType>: SegueType {
   /**
    The type of elements in sequence that observer can observe.
    */
    public typealias E = ContextType
   /**
    Type of the view controller from which navigation will appear
    */
    public typealias T = FromViewControllerType
   /**
    Type of the target view controller
    */
    public typealias U = ToViewControllerType
   /**
    Represents view controller from which navigation will appear
    */
    public weak var fromViewController: T?
   /**
    View controller factory closure, which produces view controller to navigate to
    
    - parameter sender:  view controller from which navigation will appear
    - parameter context: contex to pass to the target view controller
    
    - returns: created and configured view controller
    */
    public let toViewControllerFactory: (_ sender: T, _ context: E) -> U
   /**
    Represetns whether transitions should be animated or not
    */
    public let animated: Bool
   /**
    Constructs new navigation segue
    
    - parameter fromViewController:      view controller from which navigation will appear
    - parameter toViewControllerFactory: view controller factory closure, which produces view controller to navigate to
    - parameter animated:                represetns whether transitions should be animated or not    */
    public init(fromViewController: T,
        toViewControllerFactory: @escaping (_ sender: T, _ context: E) -> U,
        animated: Bool = true) {
            self.fromViewController = fromViewController
            self.toViewControllerFactory = toViewControllerFactory
            self.animated = animated
    }
   /**
    Notify observer about sequence event.
    
    - parameter event: Event that occured.
    */
    public func on(_ event: Event<E>) {
        MainScheduler.ensureExecutingOnScheduler()
        
        switch event {
        case .next(let element):
            guard let fromVC = fromViewController else {
                return
            }
            let toVC = toViewControllerFactory(fromVC, element)
            fromVC.pushViewController(toVC, animated: animated)
        case .error(let error):
            bindingErrorToInterface(error)
            break
        case .completed:
            break
        }
    }
   /**
    Erases type of observer and returns canonical observer.
    
    - returns: type erased observer.
    */
    func asObserver() -> AnyObserver<E> {
        return AnyObserver(eventHandler: on)
    }
}

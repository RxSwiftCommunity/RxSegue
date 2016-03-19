//
//  NavigationSegue.swift
//  Pods
//
//  Created by Segii Shulga on 3/19/16.
//
//

import UIKit
import RxSwift

public struct NavigationSegue<FromViewControllerType: UINavigationController,
ToViewControllerType: UIViewController, ContextType>: SegueType {
    public typealias E = ContextType
    public typealias T = FromViewControllerType
    public typealias U = ToViewControllerType
    
    public weak var fromViewController: T?
    public let toViewControllerFactory: (sender: T, context: E) -> U
    public let animated: Bool
    
    public init(fromViewController: T,
        toViewControllerFactory: (sender: T, context: E) -> U,
        animated: Bool = true) {
            self.fromViewController = fromViewController
            self.toViewControllerFactory = toViewControllerFactory
            self.animated = animated
    }
    
    public func on(event: Event<E>) {
        MainScheduler.ensureExecutingOnScheduler()
        
        switch event {
        case .Next(let element):
            guard let fromVC = fromViewController else {
                return
            }
            let toVC = toViewControllerFactory(sender: fromVC, context: element)
            fromVC.pushViewController(toVC, animated: animated)
        case .Error(let error):
            bindingErrorToInterface(error)
            break
        case .Completed:
            break
        }
    }
    
    func asObserver() -> AnyObserver<E> {
        return AnyObserver(eventHandler: on)
    }
}

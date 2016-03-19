//
//  ModalSegue.swift
//  Pods
//
//  Created by Segii Shulga on 3/19/16.
//
//

import UIKit
import RxSwift

public struct ModalSegue<FromViewControllerType: UIViewController,
    ToViewControllerType: UIViewController, ContextType>: SegueType {
    public typealias E = ContextType
    public typealias T = FromViewControllerType
    public typealias U = ToViewControllerType
    
    public weak var fromViewController: T?
    public let toViewControllerFactory: (sender: T, context: E) -> U
    public let animated: Bool
    let presentationCompletion: (() -> Void)?
    
    public init(fromViewController: T,
        toViewControllerFactory: (sender: T, context: E) -> U,
        animated: Bool = true,
        presentationCompletion: (() -> Void)? = nil) {
            self.fromViewController = fromViewController
            self.toViewControllerFactory = toViewControllerFactory
            self.animated = animated
            self.presentationCompletion = presentationCompletion
    }
    
    public func on(event: Event<E>) {
        MainScheduler.ensureExecutingOnScheduler()
        
        switch event {
        case .Next(let element):
            guard let fromVC = fromViewController else {
                return
            }
            let toVC = toViewControllerFactory(sender: fromVC, context: element)
            fromVC.presentViewController(toVC,
                animated: animated,
                completion: presentationCompletion)
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

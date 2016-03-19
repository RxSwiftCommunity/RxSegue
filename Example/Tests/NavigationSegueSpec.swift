//
//  NavigationSegueSpec.swift
//  RxSegue
//
//  Created by Segii Shulga on 3/19/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Quick
import Nimble
import RxSegue
import RxSwift
import RxCocoa

class NavigationSegueSpec: QuickSpec {
    
    override func spec() {
        
        describe("Navigation Segue Tests spec") { () -> Void in
            
            it("it should call toViewControllerFactory with same sender", closure: { () -> () in
                let just = Observable.just()
                var sameSender: Bool?
                let navigationController = UINavigationController(rootViewController: UIViewController())
                let segue = NavigationSegue<UINavigationController, UIViewController, Void>(
                    fromViewController: navigationController,
                    toViewControllerFactory: { (sender, context) -> UIViewController in
                        sameSender = navigationController === sender
                        return UIViewController()
                })
                _ = just.bindTo(segue)
                
                expect(sameSender).toNot(beNil())
                expect(sameSender) == true
            })
            
            it("it should not call toViewControllerFactory with empty observable", closure: { () -> () in
                let empty = Observable<Void>.empty()
                var factoryCalled = false
                let navigationController = UINavigationController(rootViewController: UIViewController())
                let segue = NavigationSegue<UINavigationController, UIViewController, Void>(
                    fromViewController: navigationController,
                    toViewControllerFactory: { (sender, context) -> UIViewController in
                        factoryCalled = true
                        return UIViewController()
                })
                _ = empty.bindTo(segue)
                expect(factoryCalled) == false
            })
            
            it("should not call toViewControllerFactory with error observable", closure: { () -> () in
                let errorObservable = Observable<Void>.error(dummyError)
                var factoryCalled = false
                var error: ErrorType?
                let navigationController = UINavigationController(rootViewController: UIViewController())
                let segue = NavigationSegue<UINavigationController, UIViewController, Void>(
                    fromViewController: navigationController,
                    toViewControllerFactory: { (sender, context) -> UIViewController in
                        factoryCalled = true
                        return UIViewController()
                })
                _ = errorObservable
                    .doOnError {
                        error = $0
                    }
                    .bindTo(segue)
                
                expect(error).toNot(beNil())
                expect(factoryCalled) == false
            })
            
            
            it("should have same context value in toViewControllerFactory", closure: { () -> () in
                
                let just = Observable.just(1)
                var expectedContext: Int?
                let navigationController = UINavigationController(rootViewController: UIViewController())
                let segue = NavigationSegue<UINavigationController, UIViewController, Int>(
                    fromViewController: navigationController,
                    toViewControllerFactory: { (sender, context) -> UIViewController in
                        expectedContext = context
                        return UIViewController()
                })
                _ = just.bindTo(segue)
                
                expect(expectedContext).toNot(beNil())
                expect(expectedContext) == 1
            })
            
        }
        
    }
    
}

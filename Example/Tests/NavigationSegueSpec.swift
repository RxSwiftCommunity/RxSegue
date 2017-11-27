//
//  NavigationSegueSpec.swift
//  RxSegue
//
//  Created by Segii Shulga on 3/19/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import XCTest
import Nimble
import RxSegue
import RxSwift

class NavigationSegueTests: XCTestCase {
    
    func test_ShouldCallToViewControllerFactoryWithSameSender() {
        let just = Observable.just(Void())
        var sameSender: Bool?
        let navigationController = UINavigationController(rootViewController: UIViewController())
        
        let segue = NavigationSegue<UINavigationController, UIViewController, Void>(
            fromViewController: navigationController,
            toViewControllerFactory: { (sender, context) -> UIViewController in
                sameSender = navigationController === sender
                return UIViewController()
        })
        _ = just.subscribe(segue)
        
        expect(sameSender).toNot(beNil())
        expect(sameSender).to(beTrue())
    }
    
    func test_ShouldNotCallToViewControllerFactoryWithEmptyObservable() {
        let empty = Observable<Void>.empty()
        var factoryCalled = false
        let navigationController = UINavigationController(rootViewController: UIViewController())
        
        let segue = NavigationSegue<UINavigationController, UIViewController, Void>(
            fromViewController: navigationController,
            toViewControllerFactory: { (sender, context) -> UIViewController in
                factoryCalled = true
                return UIViewController()
        })
        _ = empty.subscribe(segue)
        
        expect(factoryCalled).to(beFalse())
    }
    
    func test_ShouldNotCallToViewControllerFactoryWithErrorObservable() {
        let errorObservable = Observable<Void>.error(dummyError)
        var factoryCalled = false
        let navigationController = UINavigationController(rootViewController: UIViewController())
        
        let segue = NavigationSegue<UINavigationController, UIViewController, Void>(
            fromViewController: navigationController,
            toViewControllerFactory: { (sender, context) -> UIViewController in
                factoryCalled = true
                return UIViewController()
        })
        _ = errorObservable.subscribe(segue)
        
        expect(factoryCalled).to(beFalse())
    }
    
    func test_shouldHaveSameContextInFactoryClosure() {
        let just = Observable.just(1)
        var expectedContext: Int?
        let navigationController = UINavigationController(rootViewController: UIViewController())
        
        let segue = NavigationSegue<UINavigationController, UIViewController, Int>(
            fromViewController: navigationController,
            toViewControllerFactory: { (sender, context) -> UIViewController in
                expectedContext = context
                return UIViewController()
        })
        _ = just.subscribe(segue)
        
        expect(expectedContext).toNot(beNil())
        expect(expectedContext).to(be(1))
    }
    
}

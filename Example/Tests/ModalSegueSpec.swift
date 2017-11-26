//
//  ModalSegueTests.swift
//  RxSegue
//
//  Created by Segii Shulga on 3/19/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import XCTest
import Nimble
import RxSegue
import RxSwift

let dummyError = NSError(domain: "RxSegue.dummyError", code: -1, userInfo: nil)

final class ModalSegueTests: XCTestCase {
    
    func test_ShouldCallToViewControllerFactoryWithSameSender() {
        let viewController = MockViewController()
        let subject = Observable<Void>.just(Void())
        var sameSender: Bool?
        
        let segue = ModalSegue<MockViewController, UIViewController, Void>(fromViewController: viewController, toViewControllerFactory: { (sender, _) -> UIViewController in
            sameSender = viewController === sender
            return UIViewController()
        })
        
        _ = subject.subscribe(segue)
        expect(sameSender) != nil
        expect(sameSender) == true
    }
    
    func test_ShouldNotCallToViewControllerFactoryForEmptyObservable() {
        let viewController = MockViewController()
        let empty = Observable<Void>.empty()
        var factoryCalled = false
        let segue = ModalSegue<UIViewController, UIViewController, Void>(fromViewController: viewController,
                                                                         toViewControllerFactory: { (sender, context) -> UIViewController in
                                                                            factoryCalled = true
                                                                            return UIViewController()
        })
        _ = empty
            .subscribe(segue)
        expect(factoryCalled) == false
    }
    
    func test_ShouldNotCallToViewControllerFactoryWithErrorObservable() {
        let viewController = MockViewController()
        let errorObservable = Observable<Void>.error(dummyError)
        var factoryCalled = false
        let segue = ModalSegue<UIViewController, UIViewController, Void>(fromViewController: viewController,
                                                                         toViewControllerFactory: { (sender, context) -> UIViewController in
                                                                            factoryCalled = true
                                                                            return UIViewController()
        })
        _ = errorObservable
            .subscribe(segue)
        
        expect(factoryCalled) == false
    }
    
    func test_ShouldHaveSameContextValue() {
        let viewController = MockViewController()
        var expectedContext: Int?
        let subject = Observable.just(1)
        let segue = ModalSegue<UIViewController, UIViewController, Int>(fromViewController: viewController,
                                                                        toViewControllerFactory: { (sender, context) -> UIViewController in
                                                                            expectedContext = context
                                                                            return UIViewController()
        })
        _ = subject.asObservable()
            .subscribe(segue)
        expect(expectedContext) == 1
    }
    
    func test_ShouldCallCompletionBlock() {
        let viewController = MockViewController()
        let subject = Observable.just(Void())
        var completionCalled = false
        let segue = ModalSegue<MockViewController, UIViewController, Void>(
            fromViewController: viewController,
            toViewControllerFactory: { (sender, context) -> UIViewController in
                return UIViewController()
            },
            animated: true,
            presentationCompletion: {
                completionCalled = true
        })
        _ = subject.asObservable()
            .subscribe(segue)
        expect(completionCalled) == true
    }
}

//
//  ModalSegueTests.swift
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

let dummyError = NSError(domain: "RxSegue.dummyError", code: -1, userInfo: nil)

class ModalSegueTests: QuickSpec {
    
    override func spec() {
        
        describe("Modal segue tests") { () -> () in
            
            it("should call toViewControllerFactory with same sender", closure: { () -> () in
                let viewController = MockViewController()
                let subject = Observable.just()
                var sameSender: Bool?
                let segue = ModalSegue<MockViewController, UIViewController, Void>(fromViewController: viewController,
                    toViewControllerFactory: { (sender, context) -> UIViewController in
                        sameSender = viewController === sender
                        return UIViewController()
                })
                _ = subject.asObservable()
                    .bindTo(segue)
                expect(sameSender).toNot(beNil())
                expect(sameSender) == true
            })
            
            it("should not call toViewControllerFactory", closure: { () -> () in
                let viewController = MockViewController()
                let empty = Observable<Void>.empty()
                var factoryCalled = false
                let segue = ModalSegue<UIViewController, UIViewController, Void>(fromViewController: viewController,
                    toViewControllerFactory: { (sender, context) -> UIViewController in
                        factoryCalled = true
                        return UIViewController()
                })
                _ = empty
                    .bindTo(segue)
                expect(factoryCalled) == false
            })
            
            it("should not call toViewControllerFactory", closure: { () -> () in
                let viewController = MockViewController()
                let errorObservable = Observable<Void>.error(dummyError)
                var factoryCalled = false
                var error: ErrorType?
                let segue = ModalSegue<UIViewController, UIViewController, Void>(fromViewController: viewController,
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
            
            it("should have same context value of the segue", closure: { () -> () in
                let viewController = MockViewController()
                var expectedContext: Int?
                let subject = Observable.just(1)
                let segue = ModalSegue<UIViewController, UIViewController, Int>(fromViewController: viewController,
                    toViewControllerFactory: { (sender, context) -> UIViewController in
                        expectedContext = context
                        return UIViewController()
                })
                _ = subject.asObservable()
                    .bindTo(segue)
                expect(expectedContext) == 1
            })
            
            it("should call completion", closure: { () -> () in
                let viewController = MockViewController()
                let subject = Observable.just()
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
                    .bindTo(segue)
                expect(completionCalled) == true
            })
            
        }
        
    }
    
}

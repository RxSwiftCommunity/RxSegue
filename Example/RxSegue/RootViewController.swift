//
//  RootViewController.swift
//  RxSegue
//
//  Created by Segii Shulga on 3/19/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    @IBAction func presentPressed(sender: AnyObject) {
        let viewController: ViewController = StoryBoard.main.instantiateViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        present(navigationController,
            animated: true,
            completion: nil)
    }
}

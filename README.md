# RxSegue
### Reactive generic segue, implemented with RxSwift.

[![Build Status](https://travis-ci.org/RxSwiftCommunity/RxSegue.svg?branch=master)](https://travis-ci.org/RxSwiftCommunity/RxSegue)
[![Version](https://img.shields.io/cocoapods/v/RxSegue.svg?style=flat)](http://cocoapods.org/pods/RxSegue)
[![License](https://img.shields.io/cocoapods/l/RxSegue.svg?style=flat)](http://cocoapods.org/pods/RxSegue)
[![Platform](https://img.shields.io/cocoapods/p/RxSegue.svg?style=flat)](http://cocoapods.org/pods/RxSegue)

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Example

![RxSegueExample](https://github.com/RxSwiftCommunity/RxSegue/blob/master/RxSegueExample.gif)

```swift
class ViewController: BaseViewController {
    let disposeBag = DisposeBag()
    @IBOutlet var pushButton: UIButton!
    @IBOutlet var presentButton: UIButton!
    @IBOutlet weak var dismissButton: UIButton!

    var voidSegue: AnyObserver<Void> {
        return ModalSegue(fromViewController: self,
            toViewControllerFactory: { (sender, context) -> SecondViewController in
                return SecondViewController()
        }).asObserver()
    }

    var profileSegue: AnyObserver<ProfileViewModel> {
            return NavigationSegue(fromViewController: self.navigationController!,
                toViewControllerFactory: { (sender, context) -> ProfileViewController in
                    let profileViewController: ProfileViewController = ...
                        profileViewController.profileViewModel = context
                    return profileViewController
            }).asObserver()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        presentButton.rx.tap
            .bindTo(voidSegue)
            .addDisposableTo(disposeBag)

        pushButton.rx.tap
            .map {
                return ProfileViewModel(name: "John Doe",
                    email: "JohnDoe@example.com",
                    avatar: UIImage(named: "avatar"))
            }
            .bindTo(profileSegue)
            .addDisposableTo(disposeBag)
    }

}
```

## Installation

RxSegue is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "RxSegue"
```

## License

RxSegue is available under the MIT license. See the LICENSE file for more info.

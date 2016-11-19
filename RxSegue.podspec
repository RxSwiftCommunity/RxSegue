Pod::Spec.new do |s|
  s.name             = "RxSegue"
  s.version          = "1.0.1"
  s.summary          = "Reactive generic segue"

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!  
  s.description      = <<-DESC
                        Reactive generic segue.
                        Implemented with RxSwift.
                        Abstracts navigation logic

```swift
var profileSegue: NavigationSegue<UINavigationController,
ProfileViewController,
ProfileViewModel> {
   return NavigationSegue(fromViewController: self.navigationController!,
            toViewControllerFactory: { (sender, context) -> ProfileViewController in
               let profileViewController: ProfileViewController = ...
               profileViewController.profileViewModel = context
               return profileViewController
         })
   }
//----------
   pushButton.rx_tap
      .map {
         return ProfileViewModel(name: "John Doe",
                  email: "JohnDoe@example.com",
                  avatar: UIImage(named: "avatar"))
               }
               .bindTo(profileSegue)
               .addDisposableTo(disposeBag)

```
                       DESC

  s.homepage         = "https://github.com/RxSwiftCommunity/RxSegue.git"
  s.license          = 'MIT'
  s.author           = { "sergdort" => "sergdort@gmail.com" }
  s.source           = {
                         :git => "https://github.com/RxSwiftCommunity/RxSegue.git",
                         :tag => s.version.to_s
                        }
  s.social_media_url = 'https://twitter.com/SergDort'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.dependency 'RxSwift', '~> 3.0'
end

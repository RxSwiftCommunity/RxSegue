#
# Be sure to run `pod lib lint RxSegue.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "RxSegue"
  s.version          = "0.1.0"
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
                       DESC

  s.homepage         = "https://github.com/sergdort/RxSegue"
  s.license          = 'MIT'
  s.author           = { "sergdort" => "sergdort@gmail.com" }
  s.source           = { :git => "https://github.com/sergdort/RxSegue.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/SergDort'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
    s.dependency 'RxSwift', '~> 2.0'
    s.dependency 'RxCocoa', '~> 2.0'
end

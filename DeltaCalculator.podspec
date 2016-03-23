#
# Be sure to run `pod lib lint Delta.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "DeltaCalculator"
  s.version          = "1.0.4"
  s.summary          = "DeltaCalculator is a Swift Library focused on replacing reloadData() calls with animated insert, delete and move operations."

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!
  s.description      = <<-DESC
                      DeltaCalculator is a Swift Library focused on replacing reloadData()
                      calls with animated insert, delete and move operations.
                      DeltaCalculator tries to optimize the number of iterations to calculate all the changes,
                      making sure the UI thread doesn't block.
                      This framework is based on BKDeltaCalculator Objective-C library.
                       DESC

  s.homepage         = "https://github.com/ivanbruel/DeltaCalculator"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Ivan Bruel" => "ivan.bruel@gmail.com" }
  s.source           = { :git => "https://github.com/ivanbruel/DeltaCalculator.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/ivanbruel'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end

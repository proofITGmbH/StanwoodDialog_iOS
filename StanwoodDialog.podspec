#
# Be sure to run `pod lib lint StanwoodDialog.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'StanwoodDialog'
  s.version          = '0.7.2'
  s.summary          = 'Library to show a rating dialog prompt like the one used in On Air.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
This library allows to show a rating dialog prompt like the one used in On Air. 
This allows a more personal approach and dismisses automatically when no interaction.
                       DESC

  s.homepage         = 'https://github.com/stanwood/StanwoodDialog_iOS'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Eugene Peschard' => 'eugene.peschard@stanwood.io' }
  s.source           = { :git => 'https://github.com/stanwood/StanwoodDialog_iOS.git', :tag => s.version.to_s }

  s.ios.deployment_target = '10.0'

  s.source_files = 'Stanwood_Dialog_iOS/Classes/**/*.{swift}'
  
  s.resource_bundles = {
    'Stanwood_Dialog_iOS' => ['Stanwood_Dialog_iOS/Classes/**/*.{xib,png,jpeg}']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
end

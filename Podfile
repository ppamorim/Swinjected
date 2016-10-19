source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0' #old stuff :)
use_frameworks!

target 'swinjected' do
  pod 'Swinject', '2.0.0-beta.2' #this guy is magic, dependency injection for you!
  pod 'PureLayout' #There is a lot of alternatives and you don't need it to create this sample, this guy is just for views!
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '3.0'
    end
  end
end

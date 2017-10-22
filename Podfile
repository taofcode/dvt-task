source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '9.0'
use_frameworks!
inhibit_all_warnings!


abstract_target 'BasePods' do
# Core
pod 'XCGLogger', '~> 3.0'
pod 'Fargo', :git => 'https://github.com/ivasic/Fargo.git'
pod 'Alamofire', '~> 3.4'
 

# UI
pod 'DCIntrospect-ARC', :git => 'https://github.com/ivasic/DCIntrospect-ARC.git'
pod 'MBProgressHUD'
pod 'SnapKit', '~> 0.15'
target 'WeatherApplication' do
 end
end
post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '2.3'
        end
    end
end


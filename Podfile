source 'https://github.com/CocoaPods/Specs.git'
source 'https://github.com/relatedcode/ProgressHUD.git'
platform :ios, '12.0'

target 'FachaiAB' do
  pod 'SDWebImage', :modular_headers => true
  pod 'Loaf'
  pod 'SnapKit'
  pod 'AutoInch'
  pod 'UIColor_Hex_Swift', '~> 5.1.9'
  
  pod 'CL_ShanYanSDK' # 闪验
  pod 'YYText', :modular_headers => true
  # 键盘管理
  pod 'IQKeyboardManagerSwift'
  pod 'Alamofire'
  pod 'HandyJSON'
  pod 'SVProgressHUD'
  pod 'ReachabilitySwift'
#  pod 'FLEX', :configurations => ['Debug']
#  pod 'LookinServer'
end

post_install do |installer|
  installer.generated_projects.each do |project|
    project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
#            config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
#            config.build_settings["EXCLUDED_ARCHS[sdk=*]"] = "arm64"
            config.build_settings["ONLY_ACTIVE_ARCH"] = "YES"
         end
    end
  end
end


#
#  Be sure to run `pod spec lint oc-modules.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name         = "_Modules"
  s.version      = "0.4.0"
  s.summary      = "iOS 开发包 之 模块库 [Objective-C]"
  s.description  = <<-DESC
                   iOS 开发包 之 模块库 [Objective-C]
                   DESC
  s.homepage     = "https://github.com/fallending"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { '7' => 'fengzilijie@qq.com' }

  s.ios.deployment_target = '8.0'
  s.source       = { :git => 'https://github.com/fallending/oc-suite.git', :tag => s.version.to_s }

  s.subspec 'Application' do |application|
    application.source_files = "_Modules/Application/**/*.{h,m}"
    application.resources = "_Modules/Application/_AppRater.bundle"
  end
  
  s.subspec 'Components' do |components|
    components.subspec 'QRCode' do |qrcode|
      qrcode.source_files = "_Modules/Components/QRCode/**/*.{h,m}"
      qrcode.resources = "_Modules/Components/QRCode/Resource/*.png"
    end

    components.subspec 'Browser' do |browser|
      browser.source_files = "_Modules/Components/Browser/**/*.{h,m}"
      browser.resources = "_Modules/Components/Browser/web.bundle"
    end

    components.subspec 'Transaction' do |transaction|
      transaction.source_files = "_Modules/Components/Transaction/**/*.{h,m}"
      transaction.resources = "_Modules/Components/Transaction/Resource/*.bundle"
    end

    components.subspec 'Map' do |map|
      map.source_files = "_Modules/Components/Map/**/*.{h,m}"
      # map.resources = "_Modules/Components/Map/Resources/*.png"
      map.resource_bundles = {
        'MapImages' => ['_Modules/Components/Map/Resource/**/*.png'],
        'MapXibs' => ['_Modules/Components/Map/View/*.xib']
      }
      map.dependency '_Modules/Services/Map'
    end

    components.subspec 'Pay' do |pay|
      pay.source_files = "_Modules/Components/Pay/**/*.{h,m}"
      pay.resource_bundles = {
        'PayImages' => ['_Modules/Components/Pay/Resource/**/*.png'],
        'PayXibs' => ['_Modules/Components/Pay/View/*.xib']
      }
      pay.dependency '_Modules/Services/Pay'
    end

    components.subspec 'Login' do |login|
      login.source_files = "_Modules/Components/Login/**/*.{h,m}"
      login.resource_bundles = {
        'LoginImages' => ['_Modules/Components/Login/Resource/**/*.png'],
        'LoginXibs' => ['_Modules/Components/Login/View/*.xib']
      }
      login.dependency '_Modules/Services/Pay'
    end

    components.subspec 'Share' do |pay|
      pay.source_files = "_Modules/Components/Share/**/*.{h,m}"
      pay.resource_bundles = {
        'ShareImages' => ['_Modules/Components/Share/Resource/**/*.png']
      }
      # pay.dependency '_Modules/Services/Pay'
    end

  end

  s.subspec 'Midwares' do |midwares|
    midwares.source_files = "_Modules/Midwares/**/*.{h,m}"
  end

  s.subspec 'Services' do |services|
    services.subspec 'Assets' do |assets|
      assets.source_files = "_Modules/Services/Assets/**/*.{h,m}"
    end

    services.subspec 'Growth' do |growth|
      growth.source_files = "_Modules/Services/Growth/**/*.{h,m}"
    end

    services.subspec 'Image' do |image|
      image.source_files = "_Modules/Services/Image/**/*.{h,m}"
    end

    services.subspec 'Location' do |location|
      location.source_files = "_Modules/Services/Location/**/*.{h,m}"
    end

    services.subspec 'APNS' do |apns|
      apns.source_files = "_Modules/Services/APNS/**/*.{h,m}"
      apns.dependency 'JPush'
    end

    services.subspec 'Map' do |map|
      map.source_files = "_Modules/Services/Map/**/*.{h,m}"
      map.dependency 'AMap3DMap'
      map.dependency 'AMapSearch'
      map.dependency 'AMapLocation'
    end

    services.subspec 'Time' do |time|
      time.source_files = "_Modules/Services/Time/**/*.{h,m}"
    end

    services.subspec 'Rate' do |rate|
      rate.source_files = "_Modules/Services/Rate/**/*.{h,m}"
      rate.resources = "_Modules/Services/Rate/**/*.bundle"
    end

    services.subspec 'Share' do |share|
      share.source_files = "_Modules/Services/Share/**/*.{h,m}"
    end

    services.subspec 'Version' do |version|
      version.source_files = "_Modules/Services/Version/**/*.{h,m}"
    end

    services.subspec 'Pay' do |pay|
      pay.source_files = '_Modules/Services/Pay/**/*.{h,m}'
      pay.dependency 'AlipaySDK-iOS'
    end

    services.subspec 'Login' do |login|
      login.source_files = '_Modules/Services/Login/**/*.{h,m}'
      # pay.dependency 'UnionPay'
    end
  end
end

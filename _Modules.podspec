#
#  Be sure to run `pod spec lint oc-modules.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  s.name         = "_Modules"
  s.version      = "0.3.0"
  s.summary      = "iOS 开发包 之 模块库 [Objective-C]"
  s.description  = <<-DESC
                   iOS 开发包 之 模块库 [Objective-C]
                   DESC
  s.homepage     = "https://github.com/fallending"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { '7' => 'fengzilijie@qq.com' }

  s.ios.deployment_target = '8.0'
  s.source       = { :git => 'https://github.com/fallending/oc-suite.git', :tag => s.version.to_s }

  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Specify the location from where the source should be retrieved.
  #  Supports git, hg, bzr, svn and HTTP.
  #

  s.subspec 'Application' do |application|
    application.source_files = "_Modules/Application/**/*.{h,m}"
    application.resources = "_Modules/Application/_AppRater.bundle"
  end
  
  s.subspec 'Components' do |components|
    components.subspec 'QRCodeReader' do |qrCodeReader|
      qrCodeReader.source_files = "_Modules/Components/QRCodeReader/**/*.{h,m}"
      qrCodeReader.resources = "_Modules/Components/QRCodeReader/Resources/*.png"
    end

    components.subspec 'WebBrowser' do |webBrowser|
      webBrowser.source_files = "_Modules/Components/WebBrowser/**/*.{h,m}"
      webBrowser.resources = "_Modules/Components/WebBrowser/web.bundle"
    end

    components.subspec 'ALSTransaction' do |alsTransaction|
      alsTransaction.source_files = "_Modules/Components/ALSTransaction/**/*.{h,m}"
      alsTransaction.resources = "_Modules/Components/ALSTransaction/Resource/*.bundle"
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

    services.subspec 'Location' do |location|
      location.source_files = "_Modules/Services/Location/**/*.{h,m}"
    end

    services.subspec 'APNS' do |apns|
      apns.source_files = "_Modules/Services/APNS/**/*.{h,m}"
      apns.dependency 'JPush'
    end

    services.subspec 'Map' do |map|
      map.source_files = "_Modules/Services/Map/**/*.{h,m}"
      map.resource_bundles = {
        'Map' => ['_Modules/Services/Map/Resources/**/*.png']
      }
      map.dependency 'AMap3DMap'
      map.dependency 'AMapSearch'
    end

    services.subspec 'Time' do |time|
      time.source_files = "_Modules/Services/Time/**/*.{h,m}"
    end

    services.subspec 'Rate' do |rate|
      rate.source_files = "_Modules/Services/Rate/**/*.{h,m}"
      rate.resources = "_Modules/Services/Rate/**/*.bundle"
    end

    services.subspec 'Version' do |version|
      version.source_files = "_Modules/Services/Version/**/*.{h,m}"
    end

    services.subspec 'Pay' do |pay|
      pay.source_files = '_Modules/Services/Pay/**/*.{h,m}'
      pay.dependency 'UnionPay'
    end
  end
end

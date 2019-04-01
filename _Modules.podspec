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

  s.subspec 'Core' do |core|

    core.subspec 'Cache' do |cache|
      cache.source_files = "_Modules/Core/Cache/**/*.{h,m}"
    end

    core.subspec 'Database' do |database|
      database.source_files = "_Modules/Core/Database/**/*.{h,m}"
    end

    core.subspec 'Date' do |date|
      date.source_files = "_Modules/Core/Date/**/*.{h,m}"
    end

    core.subspec 'Image' do |image|
      image.source_files = "_Modules/Core/Image/**/*.{h,m}"
    end

    core.subspec 'Log' do |log|
      log.source_files = "_Modules/Core/Log/**/*.{h,m}"
    end

    core.subspec 'MJExtension' do |mj|
      mj.source_files = "_Modules/Core/MJExtension/**/*.{h,m}"
    end

    core.subspec 'Network' do |network|
      network.subspec 'Reachability' do |reachability|
        reachability.source_files = "_Modules/Core/Network/Reachability/*.{h,m}"
      end

      network.subspec 'XReachability' do |xReachability|
        xReachability.source_files = "_Modules/Core/Network/XReachability/*.{h,m}"
      end

      network.subspec 'Core' do |core|
        core.source_files = "_Modules/Core/Network/Core/**/*.{h,m}"
      end

      network.subspec 'Loader' do |loader|
        loader.source_files = "_Modules/Core/Network/Loader/**/*.{h,m}"
      end

      network.subspec 'Cookie' do |cookie|
        cookie.source_files = "_Modules/Core/Network/Cookie/*.{h,m}"
      end

      network.subspec 'Manager' do |manager|
        manager.source_files = "_Modules/Core/Network/Manager/*.{h,m}"
      end

      network.subspec 'Extension' do |extension|
        extension.source_files = "_Modules/Core/Network/Extension/*.{h,m}"
      end

      network.subspec 'Wrapper' do |wrapper|
        wrapper.source_files = "_Modules/Core/Network/Wrapper/*.{h,m}"
      end
    end

    core.subspec 'NetworkLit' do |networklit|
      networklit.source_files = "_Modules/Core/NetworkLit/**/*.{h,m}"
    end

    core.subspec 'NoSQL' do |nosql|
      nosql.source_files = "_Modules/Core/NoSQL/**/*.{h,m}"
    end

    
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

    # Social Networking Services
    services.subspec 'SNS' do |sns|
      sns.source_files = "_Modules/Services/SNS/**/*.{h,m}"

      # 友盟 https://www.jianshu.com/p/1fcc6cb49cff
      sns.dependency 'UMengUShare/UI'
      sns.dependency 'UMengUShare/Core', '6.4.8'
      sns.dependency 'UMengAnalytics-NO-IDFA', '4.1.5'
      sns.dependency 'UMengFeedback', '~> 2.3.4'
      sns.dependency 'UMengUShare/Core', '6.4.8'

      sns.dependency 'UMengUShare/Social/WeChat'
      sns.dependency 'UMengUShare/Social/ReducedSina' # 精简版 1M
      sns.dependency 'UMengUShare/Social/ReducedWeChat' # 精简版 0.2M
      sns.dependency 'UMengUShare/Social/ReducedQQ' # 精简版 0.5zM
      sns.dependency 'UMengUShare/Social/Sina'
      sns.dependency 'UMengUShare/Social/WeChat'
      sns.dependency 'UMengUShare/Social/QQ'
      sns.dependency 'UMengUShare/Social/AlipayShare'  # 集成支付宝
      sns.dependency 'UMengUShare/Social/DingDing' # 集成钉钉
      sns.dependency 'UMengUShare/Social/Email'  # 集成邮件
      sns.dependency 'UMengUShare/Social/SMS'  # 集成短信
      sns.dependency 'UMengUShare/Plugin/IDFA' # 加入IDFA获取
      sns.dependency 'UMengUShare/Social/Facebook' # 集成Facebook/Messenger
      sns.dependency 'UMengUShare/Social/Twitter'  # 集成Twitter
      sns.dependency 'UMengUShare/Social/Douban' # 集成豆瓣
      sns.dependency 'UMengUShare/Social/Renren' # 集成人人
      sns.dependency 'UMengUShare/Social/TencentWeibo' # 集成腾讯微博
      sns.dependency 'UMengUShare/Social/LaiWang'  # 集成来往(点点虫)
      sns.dependency 'UMengUShare/Social/YiXin'  # 集成易信
      sns.dependency 'UMengUShare/Social/Linkedin' # 集成领英
      sns.dependency 'UMengUShare/Social/Flickr' # 集成Flickr
      sns.dependency 'UMengUShare/Social/Kakao'  # 集成Kakao
      sns.dependency 'UMengUShare/Social/Tumblr' # 集成Tumblr
      sns.dependency 'UMengUShare/Social/Pinterest'  # 集成Pinterest
      sns.dependency 'UMengUShare/Social/Instagram'  # 集成Instagram
      sns.dependency 'UMengUShare/Social/Line' # 集成Line
      sns.dependency 'UMengUShare/Social/WhatsApp' # 集成WhatsApp
      sns.dependency 'UMengUShare/Social/YouDao' # 集成有道云笔记
      sns.dependency 'UMengUShare/Social/EverNote' # 集成印象笔记
      sns.dependency 'UMengUShare/Social/GooglePlus' # 集成Google+
      sns.dependency 'UMengUShare/Social/Pocket' # 集成Pocket
      sns.dependency 'UMengUShare/Social/DropBox'  # 集成DropBox
      sns.dependency 'UMengUShare/Social/VKontakte'  # 集成VKontakte
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

    services.subspec 'Utility' do |utility|
      utility.source_files = "_Modules/Services/Utility/**/*.{h,m,mm,c}"
      utility.libraries = "c++"
      utility.dependency "ZipArchive"
    end
  end

  s.subspec 'Tools' do |tools|
    tools.subspec 'Chronograph' do |chronograph|
      chronograph.source_files = "_Modules/Tools/Chronograph/**/*.{h,m}"
    end

    tools.subspec 'CountDown' do |countDown|
      countDown.source_files = "_Modules/Tools/CountDown/**/*.{h,m}"
    end

    tools.subspec 'HttpMock' do |httpmock|
      httpmock.source_files = '_Modules/Tools/HttpMock/**/*.{h,m}'
    end

    tools.subspec 'DyDelegate' do |del|
      del.source_files = '_Modules/Tools/DyDelegate/**/*.{h,m}'
    end
  end
end

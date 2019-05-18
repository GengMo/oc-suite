Pod::Spec.new do |s|

  s.name             = 'Framework'
  s.version          = '0.5.0'
  s.summary          = 'iOS 开发包 [Objective-C]'
  s.description      = <<-DESC
                       iOS 开发包 [Objective-C]
                       DESC

  s.homepage         = 'https://github.com/fallending'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '7' => 'fengzilijie@qq.com' }
  s.source           = { :git => 'https://github.com/fallending/oc-suite.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'
  
  ### 基础库
  ###
  s.subspec 'Foundation' do |foundation|
    foundation.source_files = "Framework/Foundation/**/*.{h,m,c}"
  end

  ### UI库 
  ###
  s.subspec 'UIKit' do |uikit|
    uikit.frameworks = 'UIKit'

    uikit.source_files = "Framework/UIKit/*.{h,m}"
  end

  ### 工具库
  ###
  s.subspec 'Core' do |core|
    core.subspec 'Cache' do |cache|
      cache.source_files = "Framework/Core/Cache/**/*.{h,m}"
    end

    core.subspec 'Chronograph' do |chronograph|
      chronograph.source_files = "Framework/Core/Chronograph/**/*.{h,m}"
    end

    core.subspec 'CountDown' do |countDown|
      countDown.source_files = "Framework/Core/CountDown/**/*.{h,m}"
    end

    core.subspec 'Database' do |database|
      database.source_files = "Framework/Core/Database/**/*.{h,m}"
    end

    core.subspec 'Date' do |date|
      date.source_files = "Framework/Core/Date/**/*.{h,m}"
    end

    core.subspec 'Delegate' do |del|
      del.source_files = 'Framework/Core/Delegate/**/*.{h,m}'
    end

    core.subspec 'Image' do |image|
      image.source_files = "Framework/Core/Image/**/*.{h,m}"
    end

    core.subspec 'Log' do |log|
      log.source_files = "Framework/Core/Log/**/*.{h,m}"
    end

    core.subspec 'MJExtension' do |mj|
      mj.source_files = "Framework/Core/MJExtension/**/*.{h,m}"
    end

    core.subspec 'Network' do |network|
      network.subspec 'Reachability' do |reachability|
        reachability.source_files = "Framework/Core/Network/Reachability/*.{h,m}"
      end

      network.subspec 'XReachability' do |xReachability|
        xReachability.source_files = "Framework/Core/Network/XReachability/*.{h,m}"
      end

      network.subspec 'Core' do |core|
        core.source_files = "Framework/Core/Network/Core/**/*.{h,m}"
      end

      network.subspec 'Cookie' do |cookie|
        cookie.source_files = "Framework/Core/Network/Cookie/*.{h,m}"
      end

      network.subspec 'Manager' do |manager|
        manager.source_files = "Framework/Core/Network/Manager/*.{h,m}"
      end

      network.subspec 'Extension' do |extension|
        extension.source_files = "Framework/Core/Network/Extension/*.{h,m}"
      end

      network.subspec 'Wrapper' do |wrapper|
        wrapper.source_files = "Framework/Core/Network/Wrapper/*.{h,m}"
      end
    end

    core.subspec 'Loader' do |loader|
      loader.source_files = "Framework/Core/Network/Loader/**/*.{h,m}"
    end

    core.subspec 'NetworkLit' do |networklit|
      networklit.source_files = "Framework/Core/NetworkLit/**/*.{h,m}"
    end

    core.subspec 'NoSQL' do |nosql|
      nosql.source_files = "Framework/Core/NoSQL/**/*.{h,m}"
    end

    core.subspec 'HttpMock' do |httpmock|
      httpmock.source_files = 'Framework/Core/HttpMock/**/*.{h,m}'
    end

    core.subspec 'Utility' do |utility|
      utility.source_files = "Framework/Core/Utility/**/*.{h,m,mm,c}"
      utility.libraries = "c++"
      utility.dependency "ZipArchive"
    end
  end

  ### 模块库
  ###
  s.subspec 'Module' do |mod|

    mod.subspec 'APNS' do |apns|
      apns.source_files = "Framework/Module/APNS/**/*.{h,m}"
      apns.dependency 'JPush'
    end

    # 应用层
    mod.subspec 'App' do |app|
      app.source_files = "Framework/Module/App/**/*.{h,m}"
    end

    #
    mod.subspec 'QRCode' do |qrcode|
      qrcode.source_files = "_Modules/Components/QRCode/**/*.{h,m}"
      qrcode.resources = "_Modules/Components/QRCode/Resource/*.png"
    end

    mod.subspec 'Browser' do |browser|
      browser.source_files = "_Modules/Components/Browser/**/*.{h,m}"
      browser.resources = "_Modules/Components/Browser/web.bundle"
    end

    mod.subspec 'Transaction' do |transaction|
      transaction.source_files = "_Modules/Components/Transaction/**/*.{h,m}"
      transaction.resources = "_Modules/Components/Transaction/Resource/*.bundle"
    end

    mod.subspec 'Map' do |map|
      map.source_files = "_Modules/Components/Map/**/*.{h,m}"
      # map.resources = "_Modules/Components/Map/Resources/*.png"
      map.resource_bundles = {
        'MapImages' => ['_Modules/Components/Map/Resource/**/*.png'],
        'MapXibs' => ['_Modules/Components/Map/View/*.xib']
      }
      map.dependency '_Modules/Services/Map'
    end

    mod.subspec 'Pay' do |pay|
      pay.source_files = "_Modules/Components/Pay/**/*.{h,m}"
      pay.resource_bundles = {
        'PayImages' => ['_Modules/Components/Pay/Resource/**/*.png'],
        'PayXibs' => ['_Modules/Components/Pay/View/*.xib']
      }
      pay.dependency '_Modules/Services/Pay'
    end

    mod.subspec 'Login' do |login|
      login.source_files = "_Modules/Components/Login/**/*.{h,m}"
      login.resource_bundles = {
        'LoginImages' => ['_Modules/Components/Login/Resource/**/*.png'],
        'LoginXibs' => ['_Modules/Components/Login/View/*.xib']
      }
      login.dependency '_Modules/Services/Pay'
    end

    mod.subspec 'Share' do |pay|
      pay.source_files = "_Modules/Components/Share/**/*.{h,m}"
      pay.resource_bundles = {
        'ShareImages' => ['_Modules/Components/Share/Resource/**/*.png']
      }
      # pay.dependency '_Modules/Services/Pay'
    end

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

    
  end

  ### 组件库
  ###
  s.subspec 'Component' do |comp|
    comp.subspec 'ActionSheetView' do |actionSheetView|
      actionSheetView.source_files = "_Components/ActionSheetView/**/*.{h,m}"
    end

    # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
    comp.subspec 'AlertView' do |alertView|
      alertView.source_files = "_Components/AlertView/**/*.{h,m}"
    end

    # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
    comp.subspec 'BadgeView' do |badgeView|
      badgeView.source_files = "_Components/BadgeView/**/*.{h,m}"
    end

    # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
    s.subspec 'BlankHolderView' do |blankHolderView|
      blankHolderView.source_files = "_Components/BlankHolderView/**/*.{h,m}"
    end

    s.subspec 'CheckBoxView' do |checkBoxView|
      checkBoxView.source_files = "_Components/CheckBoxView/**/*.{h,m}"
    end

    s.subspec 'CycleScrollView' do |cycleScrollView|
      cycleScrollView.source_files = "_Components/CycleScrollView/**/*.{h,m}"
    end

    s.subspec 'DatePickerView' do |datePickerView|
      datePickerView.source_files = "_Components/DatePickerView/**/*.{h,m}"
    end

    s.subspec 'DropDownMenu' do |dropDownMenu|
      dropDownMenu.source_files = "_Components/DropDownMenu/**/*.{h,m}"
      dropDownMenu.resources = "_Components/DropDownMenu/DropDownMenu.bundle"
    end

    s.subspec 'FiniteScrollView' do |finiteScrollView|
      finiteScrollView.source_files = "_Components/FiniteScrollView/**/*.{h,m}"
      finiteScrollView.resources = "_Components/FiniteScrollView/ZYBannerView.bundle"
    end

    s.subspec 'FlatActionSheetView' do |flatActionSheetView|
      flatActionSheetView.source_files = "_Components/FlatActionSheetView/**/*.{h,m}"
    end

    s.subspec 'ImageBrowserView' do |imageBrowserView|
      imageBrowserView.source_files = "_Components/ImageBrowserView/**/*.{h,m}"
    end

    s.subspec 'ImagePicker' do |imagePicker|
      imagePicker.source_files = "_Components/ImagePicker/**/*.{h,m}"
      imagePicker.resources = "_Components/ImagePicker/TZImagePickerController.bundle"
    end

    s.subspec 'IndicatorView' do |indicatorView|
      indicatorView.source_files = "_Components/IndicatorView/**/*.{h,m}"
    end

    s.subspec 'InfiniteScrollView' do |infiniteScrollView|
      infiniteScrollView.source_files = "_Components/InfiniteScrollView/**/*.{h,m}"
    end

    s.subspec 'KeyboardControl' do |keyboardControl|
      keyboardControl.source_files = "_Components/keyboardControl/**/*.{h,m}"
    end

    s.subspec 'LaunchAdView' do |launchAdView|
      launchAdView.source_files = "_Components/LaunchAdView/**/*.{h,m}"
    end

    s.subspec 'LoadableImageView' do |loadableImageView|
      loadableImageView.source_files = "_Components/LoadableImageView/**/*.{h,m}"
    end

    s.subspec 'LocalImageBrowser' do |localImageBrowser|
      localImageBrowser.source_files = "_Components/LocalImageBrowser/**/*.{h,m}"
      localImageBrowser.resources = "_Components/LocalImageBrowser/Resources/*.png"
    end

    s.subspec 'LocalImageEditableBrowserView' do |localImageEditableBrowserView|
      localImageEditableBrowserView.source_files = "_Components/LocalImageEditableBrowserView/**/*.{h,m}"
    end

    s.subspec 'PlaceholdView' do |placeholdView|
      placeholdView.source_files = "_Components/PlaceholdView/**/*.{h,m}"
    end

    s.subspec 'PopupView' do |popupView|
      popupView.source_files = "_Components/PopupView/**/*.{h,m}"
    end

    s.subspec 'ProgressHUD' do |progressHUD|
      progressHUD.source_files = "_Components/ProgressHUD/**/*.{h,m}"
      progressHUD.resources = "_Components/ProgressHUD/**/*.bundle"
    end

    s.subspec 'ProgressView' do |progressView|
      progressView.source_files = "_Components/ProgressView/**/*.{h,m}"
      # progressView.resources = "_Components/ProgressView/**/*.bundle"
    end

    s.subspec 'PopViewController' do |popViewController|
      popViewController.source_files = "_Components/PopViewController/**/*.{h,m}"
    end

    s.subspec 'RateView' do |rateView|
      rateView.source_files = "_Components/RateView/**/*.{h,m}"
    end

    s.subspec 'RefreshView' do |refreshView|
      refreshView.source_files = "_Components/RefreshView/**/*.{h,m}"
      refreshView.resources = "_Components/RefreshView/**/*.bundle"
    end

    s.subspec 'SegmentControl' do |segmentControl|
      segmentControl.source_files = "_Components/SegmentControl/**/*.{h,m}"
    end

    s.subspec 'SegmentView' do |segmentView|
      segmentView.source_files = "_Components/SegmentView/**/*.{h,m}"
    end

    s.subspec 'TagsView' do |tagsView|
      tagsView.source_files = "_Components/TagsView/**/*.{h,m}"
    end

    s.subspec 'UserGuideView' do |userGuideView|
      userGuideView.source_files = "_Components/UserGuideView/**/*.{h,m}"
    end

    s.subspec 'WaterFallView' do |waterFallView|
      waterFallView.source_files = "_Components/WaterFallView/**/*.{h,m}"
    end
  end

  ### 其他依赖库
end

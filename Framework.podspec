Pod::Spec.new do |s|

  s.name             = 'Framework'
  s.version          = '1.0.0'
  s.summary          = 'iOS 开发包 [Objective-C]'
  s.description      = <<-DESC
                       iOS 开发包 [Objective-C]
                       DESC

  s.homepage         = 'https://github.com/fallending'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '7' => 'fengzilijie@qq.com' }
  s.source           = { :git => 'https://github.com/fallending/oc-suite.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'
  
  ### 基础库
  ###
  s.subspec 'Foundation' do |foundation|
    foundation.source_files = "Framework/Foundation/**/*.{h,m,c}"
  end

  ### UI库 
  ###
  s.subspec 'UIKit' do |uikit|
    # uikit.frameworks = 'UIKit'
    uikit.source_files = "Framework/UIKit/**/*.{h,m}"
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

    core.subspec 'Modular' do |modular|
      modular.source_files = "Framework/Core/Modular/**/*.{h,m,mm,c}"
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
      qrcode.source_files = "Framework/Module/QRCode/**/*.{h,m}"
      qrcode.resources = "Framework/Module/Resource/*.png"
    end

    mod.subspec 'Browser' do |browser|
      browser.source_files = "Framework/Module/Browser/**/*.{h,m}"
      browser.resources = "Framework/Module/Browser/web.bundle"
    end

    mod.subspec 'Transaction' do |transaction|
      transaction.source_files = "Framework/Module/Transaction/**/*.{h,m}"
      transaction.resources = "Framework/Module/Transaction/Resource/*.bundle"
    end

    mod.subspec 'Map' do |map|
      map.source_files = "Framework/Module/Map/**/*.{h,m}"
      # map.resources = "Framework/Module/Map/Resources/*.png"
      map.resource_bundles = {
        'MapImages' => ['Framework/Module/Map/Resource/**/*.png'],
        'MapXibs' => ['Framework/Module/Map/View/*.xib']
      }
      map.dependency 'AMap3DMap'
      map.dependency 'AMapSearch'
      map.dependency 'AMapLocation'
    end

    mod.subspec 'Pay' do |pay|
      pay.source_files = "Framework/Module/Pay/**/*.{h,m}"
      pay.resource_bundles = {
        'PayImages' => ['Framework/Module/Pay/Resource/**/*.png'],
        'PayXibs' => ['Framework/Module/Pay/View/*.xib']
      }
      pay.dependency 'AlipaySDK-iOS'
    end

    mod.subspec 'Login' do |login|
      login.source_files = "Framework/Module/Login/**/*.{h,m}"
      login.resource_bundles = {
        'LoginImages' => ['Framework/Module/Login/Resource/**/*.png'],
        'LoginXibs' => ['Framework/Module/Login/View/*.xib']
      }
    end

    mod.subspec 'Share' do |pay|
      pay.source_files = "Framework/Module/Share/**/*.{h,m}"
      pay.resource_bundles = {
        'ShareImages' => ['Framework/Module/Share/Resource/**/*.png']
      }
    end

    mod.subspec 'Assets' do |assets|
      assets.source_files = "Framework/Module/Assets/**/*.{h,m}"
    end

    mod.subspec 'Growth' do |growth|
      growth.source_files = "Framework/Module/Growth/**/*.{h,m}"
    end

    mod.subspec 'Image' do |image|
      image.source_files = "Framework/Module/Image/**/*.{h,m}"
    end

    mod.subspec 'Location' do |location|
      location.source_files = "Framework/Module/Location/**/*.{h,m}"
    end


    mod.subspec 'Time' do |time|
      time.source_files = "Framework/Module/Time/**/*.{h,m}"
    end

    mod.subspec 'Rate' do |rate|
      rate.source_files = "Framework/Module/Rate/**/*.{h,m}"
      rate.resources = "Framework/Module/Rate/**/*.bundle"
    end

    mod.subspec 'Share' do |share|
      share.source_files = "Framework/Module/Share/**/*.{h,m}"
    end

    # Social Networking Services
    mod.subspec 'SNS' do |sns|
      sns.source_files = "Framework/Module/SNS/**/*.{h,m}"

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

    mod.subspec 'Version' do |version|
      version.source_files = "Framework/Module/Version/**/*.{h,m}"
    end
  end

  ### 组件库
  ###
  s.subspec 'Component' do |comp|

    comp.subspec 'Animation' do |animation|
      animation.source_files = "Framework/Component/Animation/**/*.{h,m}"
    end

    comp.subspec 'ActionSheetView' do |actionSheetView|
      actionSheetView.source_files = "Framework/Component/ActionSheetView/**/*.{h,m}"
    end

    comp.subspec 'AlertView' do |alertView|
      alertView.source_files = "Framework/Component/AlertView/**/*.{h,m}"
    end

    comp.subspec 'BadgeView' do |badgeView|
      badgeView.source_files = "Framework/Component/BadgeView/**/*.{h,m}"
    end

    comp.subspec 'BlankHolderView' do |blankHolderView|
      blankHolderView.source_files = "Framework/Component/BlankHolderView/**/*.{h,m}"
    end

    comp.subspec 'CheckBoxView' do |checkBoxView|
      checkBoxView.source_files = "Framework/Component/CheckBoxView/**/*.{h,m}"
    end

    comp.subspec 'CycleScrollView' do |cycleScrollView|
      cycleScrollView.source_files = "Framework/Component/CycleScrollView/**/*.{h,m}"
    end

    comp.subspec 'DatePickerView' do |datePickerView|
      datePickerView.source_files = "Framework/Component/DatePickerView/**/*.{h,m}"
    end

    comp.subspec 'DropDownMenu' do |dropDownMenu|
      dropDownMenu.source_files = "Framework/Component/DropDownMenu/**/*.{h,m}"
      dropDownMenu.resources = "Framework/Component/DropDownMenu/DropDownMenu.bundle"
    end

    comp.subspec 'FiniteScrollView' do |finiteScrollView|
      finiteScrollView.source_files = "Framework/Component/FiniteScrollView/**/*.{h,m}"
      finiteScrollView.resources = "Framework/Component/FiniteScrollView/ZYBannerView.bundle"
    end

    comp.subspec 'FlatActionSheetView' do |flatActionSheetView|
      flatActionSheetView.source_files = "Framework/Component/FlatActionSheetView/**/*.{h,m}"
    end

    comp.subspec 'ImageBrowserView' do |imageBrowserView|
      imageBrowserView.source_files = "Framework/Component/ImageBrowserView/**/*.{h,m}"
    end

    comp.subspec 'ImagePicker' do |imagePicker|
      imagePicker.source_files = "Framework/Component/ImagePicker/**/*.{h,m}"
      imagePicker.resources = "Framework/Component/ImagePicker/TZImagePickerController.bundle"
    end

    comp.subspec 'IndicatorView' do |indicatorView|
      indicatorView.source_files = "Framework/Component/IndicatorView/**/*.{h,m}"
    end

    comp.subspec 'InfiniteScrollView' do |infiniteScrollView|
      infiniteScrollView.source_files = "Framework/Component/InfiniteScrollView/**/*.{h,m}"
    end

    comp.subspec 'KeyboardControl' do |keyboardControl|
      keyboardControl.source_files = "Framework/Component/keyboardControl/**/*.{h,m}"
    end

    comp.subspec 'LaunchAdView' do |launchAdView|
      launchAdView.source_files = "Framework/Component/LaunchAdView/**/*.{h,m}"
    end

    comp.subspec 'LoadableImageView' do |loadableImageView|
      loadableImageView.source_files = "Framework/Component/LoadableImageView/**/*.{h,m}"
    end

    comp.subspec 'LocalImageBrowser' do |localImageBrowser|
      localImageBrowser.source_files = "Framework/Component/LocalImageBrowser/**/*.{h,m}"
      localImageBrowser.resources = "Framework/Component/LocalImageBrowser/Resources/*.png"
    end

    comp.subspec 'LocalImageEditableBrowserView' do |localImageEditableBrowserView|
      localImageEditableBrowserView.source_files = "Framework/Component/LocalImageEditableBrowserView/**/*.{h,m}"
    end

    comp.subspec 'PlaceholdView' do |placeholdView|
      placeholdView.source_files = "Framework/Component/PlaceholdView/**/*.{h,m}"
    end

    comp.subspec 'PopupView' do |popupView|
      popupView.source_files = "Framework/Component/PopupView/**/*.{h,m}"
    end

    comp.subspec 'ProgressHUD' do |progressHUD|
      progressHUD.source_files = "Framework/Component/ProgressHUD/**/*.{h,m}"
      progressHUD.resources = "Framework/Component/ProgressHUD/**/*.bundle"
    end

    comp.subspec 'ProgressView' do |progressView|
      progressView.source_files = "Framework/Component/ProgressView/**/*.{h,m}"
      # progressView.resources = "Framework/Component/ProgressView/**/*.bundle"
    end

    comp.subspec 'PopViewController' do |popViewController|
      popViewController.source_files = "Framework/Component/PopViewController/**/*.{h,m}"
    end

    comp.subspec 'RateView' do |rateView|
      rateView.source_files = "Framework/Component/RateView/**/*.{h,m}"
    end

    comp.subspec 'RefreshView' do |refreshView|
      refreshView.source_files = "Framework/Component/RefreshView/**/*.{h,m}"
      refreshView.resources = "Framework/Component/RefreshView/**/*.bundle"
    end

    comp.subspec 'SegmentControl' do |segmentControl|
      segmentControl.source_files = "Framework/Component/SegmentControl/**/*.{h,m}"
    end

    comp.subspec 'SegmentView' do |segmentView|
      segmentView.source_files = "Framework/Component/SegmentView/**/*.{h,m}"
    end

    comp.subspec 'TagsView' do |tagsView|
      tagsView.source_files = "Framework/Component/TagsView/**/*.{h,m}"
    end

    comp.subspec 'UserGuideView' do |userGuideView|
      userGuideView.source_files = "Framework/Component/UserGuideView/**/*.{h,m}"
    end

    comp.subspec 'WaterFallView' do |waterFallView|
      waterFallView.source_files = "Framework/Component/WaterFallView/**/*.{h,m}"
    end
  end

  ### 其他依赖库
end

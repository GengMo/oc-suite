#
#  Be sure to run `pod spec lint oc-components.podspec' to ensure this is a
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

  s.name         = "_Components"
  s.version      = "0.2.0"
  s.summary      = "iOS 开发包 之 UI组件库 [Objective-C]"
  s.description  = <<-DESC
                   iOS 开发包 之 UI组件库 [Objective-C]
                   DESC
  s.homepage     = "https://github.com/fallending"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { '7' => 'fengzilijie@qq.com' }

  s.ios.deployment_target = '8.0'
  s.source       = { :git => 'https://github.com/fallending/oc-suite.git', :tag => s.version.to_s }

  s.pod_target_xcconfig = { 'GCC_PREPROCESSOR_DEFINITIONS' => '$(inherited) OBJC_OLD_DISPATCH_PROTOTYPES=1'} 

  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  CocoaPods is smart about how it includes source code. For source files
  #  giving a folder will include any swift, h, m, mm, c & cpp files.
  #  For header files it will include any header in the folder.
  #  Not including the public_header_files will make all headers public.
  #

  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.subspec 'ActionSheetView' do |actionSheetView|
    actionSheetView.source_files = "_Components/ActionSheetView/**/*.{h,m}"
  end

  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.subspec 'AlertView' do |alertView|
    alertView.source_files = "_Components/AlertView/**/*.{h,m}"
  end

  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.subspec 'BadgeView' do |badgeView|
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

  s.subspec 'PopViewController' do |popViewController|
    popViewController.source_files = "_Components/PopViewController/**/*.{h,m}"
  end

  s.subspec 'ProgressHUD' do |progressHUD|
    progressHUD.source_files = "_Components/ProgressHUD/**/*.{h,m}"
    progressHUD.resources = "_Components/ProgressHUD/**/*.bundle"
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

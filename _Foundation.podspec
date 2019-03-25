#
# Be sure to run `pod lib lint test3-pod.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = '_Foundation'
  s.version          = '0.5.0'
  s.summary          = 'iOS 开发包 之 基础库[Objective-C]'
  s.description      = <<-DESC
                       iOS 开发包 之 基础库[Objective-C]
                       DESC

  s.homepage         = 'https://github.com/fallending'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '7' => 'fengzilijie@qq.com' }
  s.source           = { :git => 'https://github.com/fallending/oc-suite.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = "_Foundation/*.{h,m}", "_Foundation/Core/**/*.{h,m,c}", "_Foundation/Macros/*.{h,m,c}", "_Foundation/Modular/**/*.{h,m}"
  
  # 范本
  # https://stackoverflow.com/questions/27133993/why-isnt-my-cocoapods-post-install-hook-updating-my-preprocessor-macros

  # ――― Project Linking ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Link your library with frameworks, or libraries. Libraries do not include
  #  the lib prefix of their name.
  #

  # s.framework  = "SomeFramework"
  # s.frameworks = "SomeFramework", "AnotherFramework"

  # s.library   = "iconv"
  # s.libraries = "c++"

  # ――― Resources ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  A list of resources included with the Pod. These are copied into the
  #  target bundle with a build phase script. Anything else will be cleaned.
  #  You can preserve files from being cleaned, please don't preserve
  #  non-essential files like tests, examples and documentation.
  #

  # s.resource  = "icon.png"
  # s.resources = "Resources/*.png"

  # s.preserve_paths = "FilesToSave", "MoreFilesToSave"


  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If your library depends on compiler flags you can set them in the xcconfig hash
  #  where they will only apply to your library. If you depend on other Podspecs
  #  you can include multiple dependencies to ensure it works.

  # s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"

  # https://blog.csdn.net/TuGeLe/article/details/85049392
  # s.resource_bundles = {
  #   'test3-pod' => ['test3-pod/Assets/*.png']
  # }

  # s.source_files  = "*.{h,m}"
  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.libraries = 'icucore', 'sqlite3', 'z'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  # s.pod_target_xcconfig = { 'GCC_PREPROCESSOR_DEFINITIONS' => '$(inherited) ENABLE_IDFA=1'} OBJC_OLD_DISPATCH_PROTOTYPES

end

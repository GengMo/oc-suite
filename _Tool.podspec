#
#  Be sure to run `pod spec lint oc-tool.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name         = "_Tool"
  s.version      = "0.3.2"
  s.summary      = "iOS 开发包 之 工具库 [Objective-C]"
  s.description  = <<-DESC
                   iOS 开发包 之 工具库 [Objective-C]
                   DESC
  s.homepage     = "https://github.com/fallending"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { '7' => 'fengzilijie@qq.com' }

  s.ios.deployment_target = '8.0'
  s.source       = { :git => 'https://github.com/fallending/oc-suite.git', :tag => s.version.to_s }

  s.subspec 'Chronograph' do |chronograph|
    chronograph.source_files = "_Tool/Chronograph/**/*.{h,m}"
  end

  s.subspec 'CountDown' do |countDown|
    countDown.source_files = "_Tool/CountDown/**/*.{h,m}"
  end

  s.subspec 'MJExtension' do |mj|
    mj.source_files = "_Tool/MJExtension/**/*.{h,m}"
  end

  s.subspec 'Cache' do |cache|
    cache.source_files = "_Tool/Cache/**/*.{h,m}"
  end

  s.subspec 'Structures' do |structures|
    structures.source_files = "_Tool/Structures/**/*.{h,m}"
  end

  s.subspec 'HttpMock' do |httpmock|
    httpmock.source_files = '_Tool/HttpMock/**/*.{h,m}'
  end

  s.subspec 'NetworkLit' do |networklit|
    networklit.source_files = "_Tool/NetworkLit/**/*.{h,m}"
  end

  s.subspec 'Network' do |network|
    network.subspec 'Reachability' do |reachability|
      reachability.source_files = "_Tool/Network/Reachability/*.{h,m}"
    end

    network.subspec 'XReachability' do |xReachability|
      xReachability.source_files = "_Tool/Network/XReachability/*.{h,m}"
    end

    network.subspec 'Core' do |core|
      core.source_files = "_Tool/Network/Core/**/*.{h,m}"
    end

    network.subspec 'Loader' do |loader|
      loader.source_files = "_Tool/Network/Loader/**/*.{h,m}"
    end

    network.subspec 'Cookie' do |cookie|
      cookie.source_files = "_Tool/Network/Cookie/*.{h,m}"
    end

    network.subspec 'Manager' do |manager|
      manager.source_files = "_Tool/Network/Manager/*.{h,m}"
    end

    network.subspec 'Extension' do |extension|
      extension.source_files = "_Tool/Network/Extension/*.{h,m}"
    end

    network.subspec 'Wrapper' do |wrapper|
      wrapper.source_files = "_Tool/Network/Wrapper/*.{h,m}"
    end

  end

  s.subspec 'Database' do |database|
    database.source_files = "_Tool/Database/**/*.{h,m}"
  end

  s.subspec 'NoSQL' do |nosql|
    nosql.source_files = "_Tool/NoSQL/**/*.{h,m}"
  end

  s.subspec 'Utility' do |utility|
    utility.source_files = "_Tool/Utility/**/*.{h,m,mm,c}"
    utility.libraries = "c++"
    utility.dependency "ZipArchive"
    
  end

  s.subspec 'Image' do |image|
    image.source_files = "_Tool/Image/**/*.{h,m}"
  end

  s.subspec 'Log' do |log|
    log.source_files = "_Tool/Log/**/*.{h,m}"
  end

  s.subspec 'Date' do |date|
    date.source_files = "_Tool/Date/**/*.{h,m}"
  end

end

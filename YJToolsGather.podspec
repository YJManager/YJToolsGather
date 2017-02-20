version = "0.0.1";

Pod::Spec.new do |s|
    s.name         = "YJToolsGather"
    s.version      = version
    s.summary      = "YJToolsGather, a collection of useful Objective-C Tool Frameworks"
    s.description      = <<-DESC
                          YJToolsGather 是Objective-C常用开发工具. a collection of useful Objective-C Tool Frameworks.
                           DESC
    s.homepage     = "https://github.com/YJManager/YJToolsGather.git"

    s.license      = { :type => "MIT", :file => "LICENSE" }

    s.author       = { "houmanager" => "houmanager@Hotmail.com" }
    s.platform              = :ios, "8.0"
    s.ios.deployment_target = "8.0"
    s.requires_arc = true
    s.ios.frameworks = 'Foundation', 'UIKit'
    #s.library       = 'resolv.9'
    #s.libraries     = "libresolv.9.tbd"

    s.source         = { :git => "https://github.com/YJManager/YJToolsGather.git", :tag => "#{version}", :submodules => true }
    s.public_header_files = 'YJToolsGather/YJToolsGather/YJToolsGather/YJToolsGather.h'
    s.source_files        = 'YJToolsGather/YJToolsGather/YJToolsGather/YJToolsGather.h'

# 基本配置模块
    s.subspec 'Configure' do |ss|
        ss.source_files = 'YJToolsGather/YJToolsGather/YJToolsGather/Configure/*.{h,m}'
        ss.public_header_files = 'YJToolsGather/YJToolsGather/YJToolsGather/Configure/*.{h}'
    end

end
